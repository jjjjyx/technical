package com.common.uilt;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.util.Assert;

/**
 * 所有dao的基类
 * 有两个构造方法
 * 
 * @author 谢圣强
 * @param <T> 实体类型
 * @param <PK> 主键
 * @version 1.1
 */
public class BaseDao<T,PK extends Serializable> {
	
	
	protected Logger logger = LoggerFactory.getLogger(getClass());
	protected Class<T> entityClass;
	
	@Autowired
	protected HibernateTemplate hibernateTemplate;
	@Autowired
	private JdbcTemplate jdbcTemplate;


	/**
	 * 通过反射获取子类确定的泛型类
	 */
	@SuppressWarnings("unchecked")
	public BaseDao() {
		entityClass = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
	}

	/**
	 * 用于用于省略Dao层, 在Service层直接使用通用的BaseDao构造函数. 在构造函数中定义对象类型Class. eg.
	 * BaseDao<User, Long> userDao = new BaseDao<User, Long>(User.class);
	 */
	public BaseDao(Class<T> entityClass) {
		this.entityClass = entityClass;
	}

	/**
	 * 根据id加载PO实例, 如果二级缓存中存在, 则读取二级缓存的数据
	 * 
	 * @param id
	 * @return 返回相应的持久化PO实例
	 */
	public T load(PK id) {
		Assert.notNull(id);

		if (logger.isDebugEnabled()) {
			logger.debug("load entity id[" + id + "], entityClass["
					+ entityClass + "]");
		}
		return (T) hibernateTemplate.load(entityClass, id);
	}

	/**
	 * 根据id获取PO实例, 如果一级缓存不存在, 则从数据库中读取
	 * 
	 * @param id
	 * @return 返回相应的持久化PO实例
	 */
	public T get(PK id) {
		Assert.notNull(id);

		if (logger.isDebugEnabled()) {
			logger.debug("get entity id[" + id + "], entityClass["
					+ entityClass + "]");
		}
		T t = (T) hibernateTemplate.get(entityClass, id);

		return t;
	}

	/**
	 * 获取PO的所有对象
	 * 
	 * @return PO的所有对象
	 */
	public List<T> loadAll() {

		List<T> lst = hibernateTemplate.loadAll(entityClass);

		if (logger.isDebugEnabled()) {
			logger.debug("load all entities[" + entityClass + "]...");
		}
		return lst;
	}

	/**
	 * 保存PO
	 * 
	 * @param entity
	 */
	public Serializable save(T entity) {
		Assert.notNull(entity);

		if (logger.isDebugEnabled()) {
			logger.debug("save entity[" + entity.toString() + "], entityClass["
					+ entityClass + "]," + " information["
					+ ToStringBuilder.reflectionToString(entity) + "]");
		}
		return hibernateTemplate.save(entity);
	}

	/**
	 * 删除PO
	 * 
	 * @param entity
	 */
	public void delete(T entity) {
		Assert.notNull(entity);

		if (logger.isDebugEnabled()) {
			logger.debug("delete entity[" + entity.toString()
					+ "], entityClass[" + entityClass + "], " + "information["
					+ ToStringBuilder.reflectionToString(entity) + "]");
		}
		hibernateTemplate.delete(entity);
	}
	/**
	 *  删除po 全部对象
	 */
	public void deleteAll(Collection<T> entity){
		if (logger.isDebugEnabled()) {
			logger.debug("delete entity[" + entity.toString()
					+ "], entityClass[" + entityClass + "], " + "information["
					+ ToStringBuilder.reflectionToString(entity) + "]");
		}
		hibernateTemplate.deleteAll(entity);
	}
	/**
	 * 更新PO
	 * 
	 * @param entity
	 */
	public void update(T entity) {
		Assert.notNull(entity);

		if (logger.isDebugEnabled()) {
			logger.debug("update entity[" + entity.toString()
					+ "], entityClass[" + entityClass + "]," + " information["
					+ ToStringBuilder.reflectionToString(entity) + "]");
		}
		hibernateTemplate.update(entity);
	}

	/**
	 * 保存或更新PO
	 * 
	 * @param entity
	 */
	public void saveOrUpdate(T entity) {
		Assert.notNull(entity);

		if (logger.isDebugEnabled()) {
			logger.debug("saveOrUpdate entity[" + entity.toString()
					+ "], entityClass[" + entityClass + "], " + "information["
					+ ToStringBuilder.reflectionToString(entity) + "]");
		}
		hibernateTemplate.saveOrUpdate(entity);
	}

	/**
	 * 
	 * @param entity
	 */
	public void merge(T entity) {
		Assert.notNull(entity);

		if (logger.isDebugEnabled()) {
			logger.debug("merge entity[" + entity.toString()
					+ "], entityClass[" + entityClass + "], " + "information["
					+ ToStringBuilder.reflectionToString(entity) + "]");
		}
		hibernateTemplate.merge(entity);
	}

	/**
	 * 执行带参的HQL查询
	 * 
	 * @param sql
	 * @param params
	 * @return 查询结果
	 */
	@SuppressWarnings("unchecked")
	public List<T> find(String hql, Object... params) {
		Assert.hasText(hql);

		if (logger.isDebugEnabled()) {
			logger.debug("find entities[" + hql + "], entityClass["
					+ entityClass + "], " + "params["
					+ ToStringBuilder.reflectionToString(params) + "]");
		}

		List<T> lst = hibernateTemplate.find(hql, params);

		return lst;
	}

	@SuppressWarnings("unchecked")
	public List<T> find(final String hql, final int offset,final int max) {
		List<T> result = (List<T>) hibernateTemplate.execute(new HibernateCallback<Object>() {
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query = session.createQuery(hql);
				query.setFirstResult(offset);
				query.setMaxResults(max);
				List<T> list = query.list();
				return list;
			}
			});
		return result;
	}

	/**
	 * 取总记录数
	 * 
	 * @param hql
	 * @return
	 */
	public int getCount(String hql) {
		Integer count = (Integer) hibernateTemplate.find(hql).size();
		return count.intValue();
	}

	public Object getCount(final String where, final Object... values) {
		@SuppressWarnings("unchecked")
		Object result = hibernateTemplate.execute(new HibernateCallback<T>() {
			public T doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query = session.createQuery(where);
				if (values != null) {
					int i = 0;
					for (Object value : values) {
						if (value.equals(""))
							continue;
						query.setParameter(i, value);
						i++;
					}
				}
				return (T) query.uniqueResult();
			}
		});
		return result;
	}

	/**
	 * 对延迟加载的实体PO执行初始化
	 * 
	 * @param entity
	 */
	public void initialize(Object entity) {
		Assert.notNull(entity);
		hibernateTemplate.initialize(entity);
	}

	/**
	 * 刷新session缓存, 将缓存同步数据库
	 */
	public void flush() {
		hibernateTemplate.flush();
	}

//	/**
//	 * 执行count查询获得本次Hql查询所能获得的对象总数. 本函数只能自动处理简单的hql语句,复杂的hql, 如含有多个order by
//	 * 排序功能, 为了提高查询效率, 请另行传入countHql语句.
//	 * 
//	 * @param hql
//	 * @param countHql
//	 *            计数SQL
//	 * @param params
//	 *            查询传入参数
//	 * @return
//	 */
//	protected long countSqlResult(String Sql, String countSql, Object... params) {
//		Assert.hasText(Sql);
//		String countSqlTmp = countSql;
//
//		if (StringUtils.isBlank(countSql)) {
//			countSqlTmp = Sql;
//
//			// 以select开头查询
//			if (countSqlTmp.toLowerCase().trim().startsWith("select")) {
//				countSqlTmp = " select count(*) from ( " + countSqlTmp + " )";
//			} else {
//				countSqlTmp = " from "
//						+ StringUtils.substringAfter(countSqlTmp, "from");
//				countSqlTmp = " select count(*) " + countSqlTmp;
//			}
//		}
//
//		@SuppressWarnings("deprecation")
//		Long count = jdbcTemplate.queryForLong(countSqlTmp, params);
//
//		if (count == null) {
//			return 0;
//		} else {
//			return count.longValue();
//		}
//	}

	/**
	 * 从当前线程获取session, 如果没有, 则新建一个 包中都可见，而且其子类也能访问 注:使用时, 请判断获取的session是否属于当前事务,
	 * 如果取得的session不在事务上下文中, 需要手动release session
	 * 
	 * @return
	 */
	@SuppressWarnings("unused")
	private Session getSession() {
		return SessionFactoryUtils.getSession(
				hibernateTemplate.getSessionFactory(), true);
	}

	protected HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	/**
	 * 强烈建议JdbcTemplate 实例用于查询操作
	 * 
	 * @return
	 */

	public JdbcTemplate getJdbcTemplate() {
//		jdbcTemplate.
		return jdbcTemplate;
	}
}
