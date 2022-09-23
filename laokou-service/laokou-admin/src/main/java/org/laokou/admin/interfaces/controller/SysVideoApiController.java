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
package org.laokou.admin.interfaces.controller;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.laokou.admin.application.service.SysResourceApplicationService;
import org.laokou.admin.application.service.WorkflowTaskApplicationService;
import org.laokou.admin.interfaces.dto.SysResourceDTO;
import org.laokou.admin.interfaces.qo.SysResourceQO;
import org.laokou.admin.interfaces.vo.SysResourceAuditLogVO;
import org.laokou.admin.interfaces.vo.SysResourceVO;
import org.laokou.admin.interfaces.vo.UploadVO;
import org.laokou.common.exception.CustomException;
import org.laokou.common.utils.HttpResultUtil;
import org.laokou.log.annotation.OperateLog;
import org.laokou.redis.annotation.Lock4j;
import org.laokou.security.annotation.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
/**
 * @author Kou Shenhai
 * @version 1.0
 * @date 2022/8/19 0019 下午 3:56
 */
@RestController
@Api(value = "视频管理API",protocols = "http",tags = "视频管理API")
@RequestMapping("/sys/resource/video/api")
public class SysVideoApiController {

    @Autowired
    private SysResourceApplicationService sysResourceApplicationService;

    @Autowired
    private WorkflowTaskApplicationService workflowTaskApplicationService;

    @PostMapping("/upload")
    @ApiOperation("视频管理>上传")
    public HttpResultUtil<UploadVO> upload(@RequestPart("file") MultipartFile file) throws Exception {
        if (file.isEmpty()) {
            throw new CustomException("上传的文件不能为空");
        }
        //文件名
        final String fileName = file.getOriginalFilename();
        //文件流
        final InputStream inputStream = file.getInputStream();
        //文件大小
        final Long fileSize = file.getSize();
        return new HttpResultUtil<UploadVO>().ok(sysResourceApplicationService.uploadResource("video",fileName,inputStream,fileSize));
    }

    @PostMapping("/query")
    @ApiOperation("视频管理>查询")
    @PreAuthorize("sys:resource:video:query")
    public HttpResultUtil<IPage<SysResourceVO>> query(@RequestBody SysResourceQO qo) {
        return new HttpResultUtil<IPage<SysResourceVO>>().ok(sysResourceApplicationService.queryResourcePage(qo));
    }

    @PostMapping("/sync")
    @ApiOperation("视频管理>同步")
    @PreAuthorize("sys:resource:video:sync")
    @Lock4j(key = "video_sync_lock")
    @OperateLog(module = "视频管理",name = "视频同步")
    public HttpResultUtil<Boolean> sync(@RequestParam("code") String code) {
        return new HttpResultUtil<Boolean>().ok(sysResourceApplicationService.syncAsyncBatchResource(code));
    }

    @GetMapping(value = "/detail")
    @ApiOperation("视频管理>详情")
    @PreAuthorize("sys:resource:video:detail")
    public HttpResultUtil<SysResourceVO> detail(@RequestParam("id") Long id) {
        return new HttpResultUtil<SysResourceVO>().ok(sysResourceApplicationService.getResourceById(id));
    }

    @PostMapping(value = "/insert")
    @ApiOperation("视频管理>新增")
    @PreAuthorize("sys:resource:video:insert")
    @OperateLog(module = "视频管理",name = "视频新增")
    public HttpResultUtil<Boolean> insert(@RequestBody SysResourceDTO dto, HttpServletRequest request) {
        return new HttpResultUtil<Boolean>().ok(sysResourceApplicationService.insertResource(dto,request));
    }

    @PutMapping(value = "/update")
    @ApiOperation("视频管理>修改")
    @PreAuthorize("sys:resource:video:update")
    @OperateLog(module = "视频管理",name = "视频修改")
    public HttpResultUtil<Boolean> update(@RequestBody SysResourceDTO dto, HttpServletRequest request) {
        return new HttpResultUtil<Boolean>().ok(sysResourceApplicationService.updateResource(dto,request));
    }

    @DeleteMapping(value = "/delete")
    @ApiOperation("视频管理>删除")
    @PreAuthorize("sys:resource:video:delete")
    @OperateLog(module = "视频管理",name = "视频删除")
    public HttpResultUtil<Boolean> delete(@RequestParam("id") Long id) {
        return new HttpResultUtil<Boolean>().ok(sysResourceApplicationService.deleteResource(id));
    }

    @GetMapping(value = "/diagram")
    @ApiOperation(value = "视频管理>流程图")
    @PreAuthorize("sys:resource:video:diagram")
    public void diagram(@RequestParam("processInstanceId")String processInstanceId, HttpServletResponse response) throws IOException {
        workflowTaskApplicationService.diagramProcess(processInstanceId, response);
    }

    @GetMapping("/auditLog")
    @ApiOperation("视频管理>审批日志")
    @PreAuthorize("sys:resource:video:auditLog")
    public HttpResultUtil<List<SysResourceAuditLogVO>> auditLog(@RequestParam("resourceId") Long resourceId) {
        return new HttpResultUtil<List<SysResourceAuditLogVO>>().ok(sysResourceApplicationService.queryAuditLogList(resourceId));
    }

}