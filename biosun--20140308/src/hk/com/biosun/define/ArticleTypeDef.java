package hk.com.biosun.define;

import java.util.HashMap;

public class ArticleTypeDef {

	private static HashMap<String, ArticleTypeDef> hashMap = new HashMap<String, ArticleTypeDef>();

	String articleType;
	String articleTypeName;
	String articleTypeFlashName;

	public String getArticleType() {
		return articleType;
	}
	public void setArticleType(String articleType) {
		this.articleType = articleType;
	}
	public String getArticleTypeName() {
		return articleTypeName;
	}
	public void setArticleTypeName(String articleTypeName) {
		this.articleTypeName = articleTypeName;
	}
	public String getArticleTypeFlashName() {
		return articleTypeFlashName;
	}
	public void setArticleTypeFlashName(String articleTypeFlashName) {
		this.articleTypeFlashName = articleTypeFlashName;
	}

	static {
		ArticleTypeDef articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("about_us");
		articleTypeDef.setArticleTypeName("About Us");
		articleTypeDef.setArticleTypeFlashName("about_us");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);
		articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("sale_and_market");
		articleTypeDef.setArticleTypeName("Sale & Market");
		articleTypeDef.setArticleTypeFlashName("sale_and_market");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);

		articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("service");
		articleTypeDef.setArticleTypeName("Service");
		articleTypeDef.setArticleTypeFlashName("service");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);

		articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("careers");
		articleTypeDef.setArticleTypeName("Careers");
		articleTypeDef.setArticleTypeFlashName("careers");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);

		articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("contact");
		articleTypeDef.setArticleTypeName("Contact");
		articleTypeDef.setArticleTypeFlashName("contact");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);

		articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("terms_of_use");
		articleTypeDef.setArticleTypeName("Terms of Use");
		articleTypeDef.setArticleTypeFlashName("home");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);

		articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("help_web");
		articleTypeDef.setArticleTypeName("Help Web");
		articleTypeDef.setArticleTypeFlashName("help_web");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);

		articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("index");
		articleTypeDef.setArticleTypeName("Home");
		articleTypeDef.setArticleTypeFlashName("home");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);

		articleTypeDef = new ArticleTypeDef();
		articleTypeDef.setArticleType("reg");
		articleTypeDef.setArticleTypeName("User Registration");
		articleTypeDef.setArticleTypeFlashName("home");
		hashMap.put(articleTypeDef.getArticleType(), articleTypeDef);
	}

	public static ArticleTypeDef get(String articleType) {
		ArticleTypeDef articleTypeDef = hashMap.get(articleType);
		return articleTypeDef;
	}

	public static String getArticleTypeName(String articleType) {
		ArticleTypeDef articleTypeDef = get(articleType);
		if (articleTypeDef != null) {
			return articleTypeDef.getArticleTypeName();
		} else {
			return "";
		}
	}

	public static String getArticleTypeFlashName(String articleType) {
		ArticleTypeDef articleTypeDef = get(articleType);
		if (articleTypeDef != null) {
			return articleTypeDef.getArticleTypeFlashName();
		} else {
			return "";
		}
	}
}
