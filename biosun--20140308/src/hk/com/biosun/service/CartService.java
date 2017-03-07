package hk.com.biosun.service;

import hk.com.biosun.define.ProductCart;
import hk.com.biosun.model.ProductsTable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class CartService {
	private HashMap<String, ProductCart> hashMap = new HashMap<String, ProductCart>();

	/**
	 * 
	 * @param pId
	 * @param number
	 * @param opType
	 *            0=添加 1=修改 2=删除
	 * @return
	 */
	public int update(int pId, int number, int opType) {
		if (pId < 1) {
			return -1;
		}
		String pIdStr = String.valueOf(pId);
		if (opType < 2) {
			if (hashMap.containsKey(pIdStr)) {// 购物车中存在此商品则累加个数
				ProductCart productCart = hashMap.get(pIdStr);
				int countNew = 0;
				if (opType == 1) {// 添加
					countNew = productCart.getPCount() + number;
				} else {// 修改
					countNew = number;
				}
				if (countNew < 1) {
					countNew = 0;
				}
				ProductCart productCartNew = new ProductCart();
				productCartNew.setPId(pId);
				productCartNew.setPCount(countNew);
				hashMap.put(pIdStr, productCartNew);
			} else {// 购物车中不存在此商品
				if (opType == 1) {// 修改
					return -1;
				}
				if (number < 1) {
					return -1;
				}
				ProductCart productCartNew = new ProductCart();
				productCartNew.setPId(pId);
				productCartNew.setPCount(number);
				hashMap.put(pIdStr, productCartNew);
			}
			return 1;
		} else if (opType == 2) {
			if (hashMap.containsKey(pIdStr)) {
				hashMap.remove(pIdStr);
			} else {
				return -2;
			}
			return 1;
		}
		return -1;
	}
	public int add(int pId, int number) {
		return update(pId, number, 0);
	}

	public int change(int pId, int number) {
		return update(pId, number, 1);
	}

	public int delete(int pId) {
		return update(pId, 0, 2);
	}

	public ProductCart getProductCart(int pId) {
		return hashMap.get(String.valueOf(pId));
	}

	public List<ProductCart> getListProductCart() {
		Set<Map.Entry<String, ProductCart>> entrySet = hashMap.entrySet();
		List<ProductCart> list = new ArrayList<ProductCart>();
		ProductCart productCart;
		for (Map.Entry<String, ProductCart> entry : entrySet) {
			productCart = entry.getValue();
			list.add(productCart);
		}
		return list;
	}
	public List<ProductsTable> getListProductsTable() {
		List<ProductCart> list = getListProductCart();
		int listSize = list != null ? list.size() : 0;
		if (listSize < 1) {
			return null;
		}
		List<ProductsTable> listProductsTable = new ArrayList<ProductsTable>();
		ProductCart productCart;
		ProductsTable productsTable;
		ProductsTableService productsTableService = new ProductsTableService();
		for (int i = 0; i < listSize; i++) {
			productCart = list.get(i);
			productsTable = productsTableService.getByPKFront(productCart
					.getPId());
			if (productsTable != null) {
				listProductsTable.add(productsTable);
			}
		}
		return listProductsTable;
	}

}
