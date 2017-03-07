/*
 * This software is released under a licence similar to the Apache Software Licence.
 * See org.logicalcobwebs.proxool.package.html for details.
 * The latest version is available at http://proxool.sourceforge.net
 */
package org.logicalcobwebs.proxool;

import java.sql.Connection;

/**
 * @author Bertrand Renuart
 *
 */
public interface ConnectionValidatorIF {
    
    boolean validate(ConnectionPoolDefinitionIF cpd, Connection connection);   
}

/*
 Revision history:
 $Log: ConnectionValidatorIF.java,v $
 Revision 1.1  2004/03/25 22:02:15  brenuart
 First step towards pluggable ConnectionBuilderIF & ConnectionValidatorIF.
 Include some minor refactoring that lead to deprecation of some PrototyperController methods.

*/