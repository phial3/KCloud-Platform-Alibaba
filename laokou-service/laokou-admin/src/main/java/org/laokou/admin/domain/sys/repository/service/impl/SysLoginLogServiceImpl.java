/**
 * Copyright (c) 2022 KCloud-Platform Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.laokou.admin.domain.sys.repository.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.laokou.admin.domain.sys.entity.SysLoginLogDO;
import org.laokou.admin.domain.sys.repository.mapper.SysLoginLogMapper;
import org.laokou.admin.domain.sys.repository.service.SysLoginLogService;
import org.laokou.admin.interfaces.qo.LoginLogQO;
import org.laokou.admin.interfaces.vo.SysLoginLogVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class)
public class SysLoginLogServiceImpl extends ServiceImpl<SysLoginLogMapper, SysLoginLogDO> implements SysLoginLogService {
    @Override
    public IPage<SysLoginLogVO> getLoginLogList(IPage<SysLoginLogVO> page, LoginLogQO qo) {
        return this.baseMapper.getLoginLogList(page,qo);
    }
}