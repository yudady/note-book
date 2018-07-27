package com.tommy.mybatis.dao;

import com.tommy.mybatis.model.PyCust;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface PyCustMapper {


    int deleteByPrimaryKey(String id);

    int insert(PyCust record);

    int insertSelective(PyCust record);

    PyCust selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PyCust record);

    int updateByPrimaryKey(PyCust record);

    List<PyCust> selectAll();
}