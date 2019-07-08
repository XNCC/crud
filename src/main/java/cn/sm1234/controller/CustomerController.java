package cn.sm1234.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.sm1234.domain.Customer;
import cn.sm1234.service.CustomerService;
import com.github.pagehelper.PageInfo;
@Controller
public class CustomerController {

    //注入service对象
    @Resource
    private CustomerService customerService;

    Map<String,Object> result=new HashMap<String ,Object>();
    @RequestMapping("/listBypage")
    @ResponseBody  // 分页查询用于转换对象为json
    public  Map<String,Object> listBypage(Integer page,Integer rows) {
        //查询数据
        List<Customer> list = customerService.findAll(page,rows);
       /*
        //设置分页参数 需要在service中设置
        PageHelper.startPage(page,rows);
        */
        //将查询结果集封装到pageinfo对象中
        PageInfo<Customer> pageInfo=new PageInfo<Customer>(list);
        long total=pageInfo.getTotal();
        List<Customer> custList=pageInfo.getList();
        //转换城map集合 map集合会被自动转城json格式
        result.put("total",total);   //总记录数
        result.put("rows",custList); //当前页面的数据
        return result;
    }


    //增加
    @RequestMapping(value="/saveUser",method = RequestMethod.POST)
    public String save(Customer customer){
        customer.setId(null);
        customerService.save(customer);
        System.out.println("save"+customer);
        return "success";
    }

    //修改
    @RequestMapping(value="/updateUser",method = RequestMethod.POST)
    public void update(Customer customer){
        customerService.save(customer);
        System.out.println(customer);
    }

    //删除
    @RequestMapping(value="/destroyUser",method = RequestMethod.POST)
    @ResponseBody
    public String destroyUser(int id){
        customerService.delete(id);
        return "success";
    }

}
