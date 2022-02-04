package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.PointsMapper;
import vo.PointsVO;

@Service
public class PointsServiceImpl implements PointsService{
	
	@Autowired
	PointsMapper dao;
	
	@Override
	public int send(PointsVO vo) {
		return dao.send(vo) ;
	}

	@Override
	public int updategiver(PointsVO vo) {
		return dao.updategiver(vo);
	}

	@Override
	public int updategrantee(PointsVO vo) {
		return dao.updategrantee(vo);
	}

}
