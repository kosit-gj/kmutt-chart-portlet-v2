package th.ac.kmutt.chart.model;

import java.io.Serializable;

import com.thoughtworks.xstream.annotations.XStreamAlias;

import th.ac.kmutt.chart.xstream.common.ImakeXML;

@XStreamAlias("RoleM")
public class RoleM extends ImakeXML implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long roleId;
	private String name;
	public Long getRoleId() {
		return roleId;
	}
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	

}
