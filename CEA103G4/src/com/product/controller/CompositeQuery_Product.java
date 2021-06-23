/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *     所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */

package com.product.controller;

import java.util.*;

public class CompositeQuery_Product {

	public static String get_aCondition_For_myDB(String columnName, String value) {

		String aCondition = null;

		if ("product_name".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'" + " order by rand()" ;
		else if ("pdtype_no".equals(columnName))
			aCondition = columnName + "=" + value + " order by rand()" ;
		else if ("product_no".equals(columnName))
			aCondition = columnName + "=" + value + " order by product_no desc";
		else if ("product_price".equals(columnName))
			aCondition = columnName + "=" + value + " order by product_price";
		else if ("product_price2".equals("product_price2"))
			aCondition = "product_price" + "=" + "product_price" + " order by product_price desc";

		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();

		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];

			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_myDB(key, value.trim());

				if (count >= 1)

					whereCondition.append(" and " + aCondition);

//				System.out.println("有送出查詢資料的欄位數count = " + count);
			}
		}
		
		return whereCondition.toString();
	}

	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("product_state", new String[] { "1" });
		map.put("product_name", new String[] { "測" });
//		map.put("job", new String[] { "PRESIDENT" });
//		map.put("hiredate", new String[] { "1981-11-17" });
//		map.put("sal", new String[] { "5000.5" });
//		map.put("comm", new String[] { "0.0" });
//		map.put("deptno", new String[] { "10" });
		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

		String finalSQL = "select * from PRODUCT where product_photo IS NOT NULL"
				          + CompositeQuery_Product.get_WhereCondition(map)
				          + "order by rand()";
//		System.out.println("●●finalSQL = " + finalSQL);

	}
}
