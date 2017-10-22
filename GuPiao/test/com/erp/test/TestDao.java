package com.erp.test;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.erp.entity.data.mng.Eacode;

public class TestDao {

    private JdbcTemplate jdbcT = (JdbcTemplate) SpringUtil
            .getBean("jdbcTemplate");

    public List findALL() {
        String sql = "select * from Eacode";
        return jdbcT.queryForList(sql);        
    }

    public List<Eacode> findALLEacodes() {
        List<Eacode> eacodes = new ArrayList<Eacode>();;
        String sql = "select * from Eacode";
        List list = jdbcT.queryForList(sql); 
        Iterator iterator = list.iterator();
        Eacode eacode = null;
        while (iterator.hasNext()) {
            Map map4book = (Map) iterator.next();
            eacode = new Eacode();
            
            eacode.setCode((String)map4book.get("code"));
            eacodes.add(eacode);
        }
        return eacodes;
    }    
    public int delete(int bid){
        String sql = "delete from BookInfo where bid =?";
        return jdbcT.update(sql, new Object[]{bid});
    }     
    public static void main(String[] args) {        
        List<Eacode> eacodes = new TestDao().findALLEacodes();;
        for(Eacode code:eacodes){
            System.out.println(code.getCode());
        }
    }
}
