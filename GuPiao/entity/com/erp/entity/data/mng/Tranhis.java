package com.erp.entity.data.mng;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;

@Entity
@Table(name = "tranhis")
@Et(beanId = "id", beanName = "tranhis")
public class Tranhis implements java.io.Serializable {

	@Ef(exclude="1")
	private long id;
	@Ef(width=70,fseq=1)
	private String code;

	private int side;
	private int inxh;
	private int nums;
	private double cost;
	private double fdyk;
	private double price;
	@Ef(width=145,fseq=2)
	private String in_date;
	@Ef(width=145,fseq=3)
	private String tran_date;

	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getSide() {
		return side;
	}

	public void setSide(int side) {
		this.side = side;
	}

	public int getInxh() {
		return inxh;
	}

	public void setInxh(int inxh) {
		this.inxh = inxh;
	}

	public int getNums() {
		return nums;
	}

	public void setNums(int nums) {
		this.nums = nums;
	}

	public double getCost() {
		return cost;
	}

	public void setCost(double cost) {
		this.cost = cost;
	}

	public double getFdyk() {
		return fdyk;
	}

	public void setFdyk(double fdyk) {
		this.fdyk = fdyk;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getIn_date() {
		return in_date;
	}

	public void setIn_date(String in_date) {
		this.in_date = in_date;
	}

	public String getTran_date() {
		return tran_date;
	}

	public void setTran_date(String tran_date) {
		this.tran_date = tran_date;
	}

}
