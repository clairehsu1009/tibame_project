package com.liveBid.websocket.jedis;

import java.util.List;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class JedisHandleBid {

	private static JedisPool pool = JedisPoolUtil.getJedisPool();

	public static List<String> getHistoryMsg(String live_no) {
		String key = new StringBuilder(live_no).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(10);
		List<String> historyData = jedis.lrange(key, 0, -1);
		jedis.close();
		return historyData;
	}

	public static void saveChatMessage(String live_no, String message) {
		// 對雙方來說，都要各存著歷史聊天記錄
		String live_no_Key = new StringBuilder(live_no).toString();
		Jedis jedis = pool.getResource();

		jedis.auth("123456");
		jedis.select(10);
		jedis.rpush(live_no_Key, message);

		jedis.close();
	}
	
	public static void saveMaxPrice(String live_no, String product_no,String message) {
		// 對雙方來說，都要各存著歷史聊天記錄
		String maxprivceKey = new StringBuilder(live_no).append(":").append(product_no).toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(5);
		jedis.set(maxprivceKey, message);

		jedis.close();
	}
	
	public static String getMaxPrice(String live_no,String product_no) {
		// 對雙方來說，都要各存著歷史聊天記錄
		String maxprivceKey = new StringBuilder(live_no).append(":").append(product_no).toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(5);
		String max = jedis.get(maxprivceKey);

		jedis.close();
		return max;
	}
}
