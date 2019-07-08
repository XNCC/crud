package cn.sm1234.service;

import java.util.List;

import cn.sm1234.domain.Customer;


public interface    CustomerService {

	/**
	 * 查询所有数据
	 */
	public List<Customer> findAll(Integer page,Integer rows);

	public void save(Customer customer);

	public Customer findById(Integer id);

	public void deletes(Integer[] id);
	public void delete(int id);
}
