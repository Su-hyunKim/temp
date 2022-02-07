package mapperInterface;

import java.util.List;

import vo.PurproductVO;

public interface PurproductMapper {

	// 기본 CRUD
			List<PurproductVO> selectList(); //selectList
			PurproductVO selectOne(PurproductVO vo); //selectOne
			int insert(PurproductVO vo); //insert
			int update(PurproductVO vo); //update
			int delete(PurproductVO vo); //delete
}
