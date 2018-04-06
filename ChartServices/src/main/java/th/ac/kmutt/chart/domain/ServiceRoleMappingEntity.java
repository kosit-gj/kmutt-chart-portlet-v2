package th.ac.kmutt.chart.domain;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "SERVICE_ROLE_MAPPING", schema = "", catalog = "CHART_DB")
public class ServiceRoleMappingEntity implements Serializable {
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EmbeddedId
	private ServiceRoleMappingEntityPK id;
	public ServiceRoleMappingEntityPK getId() {
		return id;
	}
	public void setId(ServiceRoleMappingEntityPK id) {
		this.id = id;
	}
    
    
}
