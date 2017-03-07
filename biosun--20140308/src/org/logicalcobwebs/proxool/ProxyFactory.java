/*
 * This software is released under a licence similar to the Apache Software Licence.
 * See org.logicalcobwebs.proxool.package.html for details.
 * The latest version is available at http://proxool.sourceforge.net
 */
package org.logicalcobwebs.proxool;

import org.logicalcobwebs.cglib.proxy.Enhancer;
import org.logicalcobwebs.cglib.proxy.Factory;
import org.logicalcobwebs.cglib.proxy.Callback;
import org.logicalcobwebs.cglib.core.NamingPolicy;
import org.logicalcobwebs.cglib.core.Predicate;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.Statement;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.util.HashSet;
import java.util.Set;
import java.util.Map;
import java.util.HashMap;
import java.lang.reflect.Modifier;

/**
 * A central place to build proxy objects. It will also provide the original
 * object given a proxy.
 * 
 * @author Bill Horsman (bill@logicalcobwebs.co.uk)
 * @author $Author: billhorsman $ (current maintainer)
 * @version $Revision: 1.33 $, $Date: 2006/04/09 21:08:43 $
 * @since Proxool 0.5
 */
class ProxyFactory {

	private static final Log LOG = LogFactory.getLog(ProxyFactory.class);

	private static Map interfaceMap = new HashMap();

	/**
	 * This naming policy stops conflicts with other Cglib instances that are
	 * running (Even ones in different packages). Without using our own naming
	 * policy we end up with exceptions like:
	 * 
	 * <pre>
	 * java.lang.LinkageError: duplicate class definition:
	 *   $java/lang/Object$$FastClassByCGLIB$$3f697993
	 * </pre>
	 */
	private static NamingPolicy NAMING_POLICY = new NamingPolicy() {
		public String getClassName(String prefix, String source, Object key,
				Predicate names) {
			StringBuffer sb = new StringBuffer();
			sb.append((prefix != null) ? (prefix.startsWith("java") ? "$"
					+ prefix : prefix) : "net.sf.cglib.empty.Object");
			sb.append("$$");
			sb.append(source.substring(source.lastIndexOf('.') + 1));
			sb.append("ByProxool$$");
			sb.append(Integer.toHexString(key.hashCode()));
			String base = sb.toString();
			String attempt = base;
			int index = 2;
			while (names.evaluate(attempt)) {
				attempt = base + "_" + index++;
			}

			return attempt;
		}
	};

	/**
	 * Wraps up a proxyConnection inside a {@link WrappedConnection} and then
	 * proxies it as a simple {@link Connection}. You should call this
	 * immediately before the connection is served to the user. The
	 * WrappedConnection is disposable (it is thrown away when the connection is
	 * returned to the pool).
	 * 
	 * @param proxyConnection
	 *            the pooled connection we are wrapping up
	 * @return the Connection for use
	 */
	protected static Connection getWrappedConnection(
			ProxyConnection proxyConnection) {
		return (Connection) getProxy(proxyConnection.getConnection(),
				new WrappedConnection(proxyConnection), proxyConnection
						.getDefinition());
	}

	/**
	 * Proxies a statement inside a {@link ProxyStatement}.
	 * 
	 * @param delegate
	 *            the real statement
	 * @param connectionPool
	 *            the pool it belongs to
	 * @param proxyConnection
	 *            the connection it was built from
	 * @param sqlStatement
	 *            Can be null?
	 * @return the proxied statement
	 */
	protected static Statement getStatement(Statement delegate,
			ConnectionPool connectionPool, ProxyConnectionIF proxyConnection,
			String sqlStatement) {
		return (Statement) getProxy(delegate, new ProxyStatement(delegate,
				connectionPool, proxyConnection, sqlStatement), proxyConnection
				.getDefinition());
	}

	/**
	 * Create a new DatabaseMetaData from a connection
	 * 
	 * @param databaseMetaData
	 *            the meta data we use to delegate all calls to (except
	 *            getConnection())
	 * @param wrappedConnection
	 *            the connection we return if asked for the connection
	 * @return databaseMetaData
	 */
	protected static DatabaseMetaData getDatabaseMetaData(
			DatabaseMetaData databaseMetaData, Connection wrappedConnection) {
		return (DatabaseMetaData) getProxy(databaseMetaData,
				new ProxyDatabaseMetaData(databaseMetaData, wrappedConnection),
				null);
	}

	private static Object getProxy(Object delegate, Callback callback,
			ConnectionPoolDefinitionIF def) {
		Enhancer e = new Enhancer();
		e.setNamingPolicy(NAMING_POLICY);
		e.setInterfaces(getInterfaces(delegate.getClass(), def));
		e.setCallback(callback);
		e.setClassLoader(ProxyFactory.class.getClassLoader());
		return e.create();
	}

	/**
	 * Gets the real Statement that we got from the delegate driver. This is no
	 * longer necessary and only provided for backwards compatability.
	 * 
	 * @param statement
	 *            proxy statement
	 * @return delegate statement
	 * @see ProxoolFacade#getDelegateStatement(java.sql.Statement)
	 */
	protected static Statement getDelegateStatement(Statement statement) {
		Statement ds = statement;
		ProxyStatement ps = (ProxyStatement) ((Factory) statement)
				.getCallback(0);
		ds = ps.getDelegateStatement();
		return ds;
	}

	/**
	 * Gets the real Connection that we got from the delegate driver. This is no
	 * longer necessary and only provided for backwards compatability.
	 * 
	 * @param connection
	 *            proxy connection
	 * @return deletgate connection
	 * @see ProxoolFacade#getDelegateConnection(java.sql.Connection)
	 */
	protected static Connection getDelegateConnection(Connection connection) {
		WrappedConnection wc = (WrappedConnection) ((Factory) connection)
				.getCallback(0);
		return wc.getProxyConnection().getConnection();
	}

	/**
	 * Get all the interfaces that a class implements. Drills down into super
	 * interfaces too and super classes too. The results are cached so it's very
	 * fast second time round.
	 * 
	 * @param clazz
	 *            the class to examine.
	 * @return an array of classes (all interfaces) that this class implements.
	 */
	private static Class[] getInterfaces(Class clazz,
			ConnectionPoolDefinitionIF cpd) {
		Class[] interfaceArray = (Class[]) interfaceMap.get(clazz);
		if (interfaceArray == null) {
			Set interfaces = new HashSet();
			traverseInterfacesRecursively(interfaces, clazz);
			if (cpd != null) {
				// Work out which interface we should be injecting (if it has
				// been configured). Make sure
				// we check CallableStatement then PreparedStatement then
				// Statement or all three will get
				// caught by Statement
				if (Connection.class.isAssignableFrom(clazz)) {
					Class injectableClass = cpd
							.getInjectableConnectionInterface();
					// Inject it if it was configured.
					if (injectableClass != null) {
						interfaces.add(injectableClass);
						if (LOG.isDebugEnabled()) {
							LOG.debug(injectableClass + " into " + clazz);
						}
					}
				}
				if (CallableStatement.class.isAssignableFrom(clazz)) {
					if (LOG.isDebugEnabled()) {
						LOG
								.debug("Getting injectableCallableStatementInterface");
					}
					Class injectableClass = cpd
							.getInjectableCallableStatementInterface();
					// Inject it if it was configured.
					if (injectableClass != null) {
						interfaces.add(injectableClass);
						if (LOG.isDebugEnabled()) {
							LOG.debug(injectableClass + " into " + clazz);
						}
					}
				}
				if (PreparedStatement.class.isAssignableFrom(clazz)) {
					Class injectableClass = cpd
							.getInjectablePreparedStatementInterface();
					// Inject it if it was configured.
					if (injectableClass != null) {
						interfaces.add(injectableClass);
						if (LOG.isDebugEnabled()) {
							LOG.debug(injectableClass + " into " + clazz);
						}
					}
				}
				if (Statement.class.isAssignableFrom(clazz)) {
					Class injectableClass = cpd
							.getInjectableStatementInterface();
					// Inject it if it was configured.
					if (injectableClass != null) {
						interfaces.add(injectableClass);
						if (LOG.isDebugEnabled()) {
							LOG.debug(injectableClass + " into " + clazz);
						}
					}
				}
			}
			interfaceArray = (Class[]) interfaces.toArray(new Class[interfaces
					.size()]);
			if (LOG.isDebugEnabled()) {
				for (int i = 0; i < interfaceArray.length; i++) {
					Class aClass = interfaceArray[i];
					LOG.debug(aClass);
				}
			}
			interfaceMap.put(clazz, interfaceArray);
			/*
			 * } else { if (LOG.isDebugEnabled()) { LOG.debug("Reusing " +
			 * interfaceArray.length + " interfaces already looked up for " +
			 * clazz); }
			 */
		}
		return interfaceArray;
	}

	/**
	 * Recursively looks at all interfaces for a class. Also looks at interfaces
	 * implemented by the super class (and its super class, etc.) Quite a lot of
	 * processing involved so you shouldn't call it too often.
	 * 
	 * @param interfaces
	 *            this set is populated with all interfaceMap it finds
	 * @param clazz
	 *            the base class to analyze
	 */
	private static void traverseInterfacesRecursively(Set interfaces,
			Class clazz) {
		// Check for circular reference (avoid endless recursion)
		if (interfaces.contains(clazz)) {
			// Skip it, we've already been here.
			/*
			 * if (LOG.isDebugEnabled()) { LOG.debug("Skipping " + clazz + "
			 * because we've already traversed it"); }
			 */
		} else {
			/*
			 * if (LOG.isDebugEnabled()) { LOG.debug("Analyzing " + clazz); }
			 */
			Class[] interfaceArray = clazz.getInterfaces();
			for (int i = 0; i < interfaceArray.length; i++) {
				/*
				 * if (LOG.isDebugEnabled()) { LOG.debug("Adding " +
				 * interfaceArray[i]); }
				 */
				traverseInterfacesRecursively(interfaces, interfaceArray[i]);
				// We're only interested in public interfaces. In fact,
				// including
				// non-public interfaces will give IllegalAccessExceptions.
				if (Modifier.isPublic(interfaceArray[i].getModifiers())) {
					interfaces.add(interfaceArray[i]);
				}
			}
			Class superClazz = clazz.getSuperclass();
			if (superClazz != null) {
				traverseInterfacesRecursively(interfaces, superClazz);
			}
			/*
			 * if (LOG.isDebugEnabled()) { LOG.debug("Found " +
			 * interfaceArray.length + " interfaceMap for " + clazz); }
			 */
		}
	}

	/**
	 * Get the WrappedConnection behind this proxy connection.
	 * 
	 * @param connection
	 *            the connection that was served
	 * @return the wrapped connection or null if it couldn't be found
	 */
	public static WrappedConnection getWrappedConnection(Connection connection) {
		return (WrappedConnection) ((Factory) connection).getCallback(0);
	}

}

/*
 * Revision history: $Log: ProxyFactory.java,v $ Revision 1.33 2006/04/09
 * 21:08:43 billhorsman Use our own naming policy for Cglib to avoid duplicate
 * class definition exceptions.
 * 
 * Revision 1.32 2006/01/18 14:40:02 billhorsman Unbundled Jakarta's Commons
 * Logging.
 * 
 * Revision 1.31 2005/09/26 09:59:22 billhorsman Explicitly use the ProxyFactory
 * class loader when using Cglib's Enhancer to avoid class loading issues.
 * 
 * Revision 1.30 2005/05/04 16:31:41 billhorsman Use the definition referenced
 * by the proxy connection rather than the pool instead.
 * 
 * Revision 1.29 2004/07/27 21:44:15 billhorsman Remove insane amount of debug
 * logging.
 * 
 * Revision 1.28 2004/06/17 21:58:36 billhorsman Injectable interface fixes.
 * 
 * Revision 1.27 2004/06/02 20:50:47 billhorsman Dropped obsolete
 * InvocationHandler reference and injectable interface stuff.
 * 
 * Revision 1.26 2004/03/23 21:19:45 billhorsman Added disposable wrapper to
 * proxied connection. And made proxied objects implement delegate interfaces
 * too.
 * 
 * Revision 1.25 2003/12/12 19:29:47 billhorsman Now uses Cglib 2.0
 * 
 * Revision 1.24 2003/09/30 18:39:08 billhorsman New test-before-use,
 * test-after-use and fatal-sql-exception-wrapper-class properties.
 * 
 * Revision 1.23 2003/09/10 22:21:04 chr32 Removing > jdk 1.2 dependencies.
 * 
 * Revision 1.22 2003/09/07 22:11:31 billhorsman Remove very persistent debug
 * message
 * 
 * Revision 1.21 2003/08/27 18:03:20 billhorsman added new
 * getDelegateConnection() method
 * 
 * Revision 1.20 2003/03/11 14:51:54 billhorsman more concurrency fixes relating
 * to snapshots
 * 
 * Revision 1.19 2003/03/10 23:43:13 billhorsman reapplied checkstyle that i'd
 * inadvertently let IntelliJ change...
 * 
 * Revision 1.18 2003/03/10 15:26:49 billhorsman refactoringn of concurrency
 * stuff (and some import optimisation)
 * 
 * Revision 1.17 2003/03/05 18:42:33 billhorsman big refactor of prototyping and
 * house keeping to drastically reduce the number of threads when using many
 * pools
 * 
 * Revision 1.16 2003/03/03 11:11:58 billhorsman fixed licence
 * 
 * Revision 1.15 2003/02/19 15:14:32 billhorsman fixed copyright (copy and paste
 * error, not copyright change)
 * 
 * Revision 1.14 2003/02/12 12:28:27 billhorsman added url, proxyHashcode and
 * delegateHashcode to ConnectionInfoIF
 * 
 * Revision 1.13 2003/02/06 17:41:04 billhorsman now uses imported logging
 * 
 * Revision 1.12 2003/01/31 14:33:18 billhorsman fix for DatabaseMetaData
 * 
 * Revision 1.11 2003/01/27 18:26:39 billhorsman refactoring of ProxyConnection
 * and ProxyStatement to make it easier to write JDK 1.2 patch
 * 
 * Revision 1.10 2002/12/16 11:15:19 billhorsman fixed getDelegateStatement
 * 
 * Revision 1.9 2002/12/16 10:57:47 billhorsman add getDelegateStatement to
 * allow access to the delegate JDBC driver's Statement
 * 
 * Revision 1.8 2002/12/12 10:48:25 billhorsman checkstyle
 * 
 * Revision 1.7 2002/12/08 22:17:35 billhorsman debug for proxying statement
 * interfaces
 * 
 * Revision 1.6 2002/12/06 15:57:08 billhorsman fix for proxied statement where
 * Statement interface is not directly implemented.
 * 
 * Revision 1.5 2002/12/03 12:24:00 billhorsman fixed fatal sql exception
 * 
 * Revision 1.4 2002/11/09 15:56:52 billhorsman fix doc
 * 
 * Revision 1.3 2002/11/02 14:22:15 billhorsman Documentation
 * 
 * Revision 1.2 2002/10/30 21:25:08 billhorsman move createStatement into
 * ProxyFactory
 * 
 * Revision 1.1 2002/10/30 21:19:16 billhorsman make use of ProxyFactory
 * 
 */
