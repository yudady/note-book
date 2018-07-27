package com.tommy.springboot.service.rd;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tommy.mybatis.dao.PyCustMapper;
import com.tommy.mybatis.model.PyCust;
@Service
public class RdCustService {

	@Autowired
	private PyCustMapper pyCustMapper;

	public List<PyCust> selectAll() {
		List<PyCust> pyCusts = pyCustMapper.selectAll();
		return pyCusts;
	}
}
