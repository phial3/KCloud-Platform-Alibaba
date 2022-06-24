package io.laokou.admin.domain.sys.repository.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.laokou.admin.domain.sys.entity.SysRoleMenuDO;
import io.laokou.admin.domain.sys.repository.dao.SysRoleMenuDao;
import io.laokou.admin.domain.sys.repository.service.SysRoleMenuService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class)
public class SysRoleMenuServiceImpl extends ServiceImpl<SysRoleMenuDao, SysRoleMenuDO> implements SysRoleMenuService{


}