package io.laokou.admin.interfaces.qo;

import io.laokou.common.entity.BasePage;
import lombok.Data;

@Data
public class OperateLogQO extends BasePage {

    private String module;

    private Integer requestStatus;

}