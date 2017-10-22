package common.statistics;

import java.util.HashMap;
import java.util.Map;

import org.da.expressionj.expr.parser.EquationParser;
import org.da.expressionj.expr.parser.ParseException;
import org.da.expressionj.model.Equation;
import org.da.expressionj.model.Expression;
import org.da.expressionj.util.ExpressionCombiner;
import org.junit.Before;
import org.junit.Test;

import com.base.common.SysConstants;

public class testStat {
	private EquationUtil equationUtil;

	@Before
	public void before() throws IllegalAccessException, InstantiationException {
		equationUtil = new EquationUtil();
		equationUtil.register(EqualNum.class);
		equationUtil.register(EqualLogic.class);
		equationUtil.register(EqualStr.class);
	}

	@Test
	public void or() throws ParseException {
		// 多个表达式中的变量名不可重复
		Equation condition = EquationParser.parse("or(a,b)");
		Equation condition2 = EquationParser.parse("c + d >0");
		Equation condition3 = EquationParser.parse("e < 0");
		Expression expr = condition2.getExpression();
		Expression expr1 = condition3.getExpression();

		ExpressionCombiner combiner = new ExpressionCombiner();
		Expression exprResult = combiner.replace(condition, "a", expr);
		Expression exprResult1 = combiner.replace(condition, "b", expr1);

		exprResult.getVariable("c").setValue(1);
		exprResult.getVariable("d").setValue(2);
		exprResult.getVariable("e").setValue(3);

		System.out.println("or:" + condition.eval());

	}

	@Test
	public void orArray() throws ParseException {

		// 从配置中直接读取
		String expr = "orArray(a)";

		// 从通过配置动态获取
		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", new Boolean[] { false, true });
		Object result = equationUtil.evaluate(expr, o);
		System.out.println("orArray:" + result);

	}

	@Test
	public void andArray() throws ParseException {

		// 从配置中直接读取
		String expr = "andArray(a)";

		// 从通过配置动态获取
		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", new Boolean[] { true, true });
		Object result = equationUtil.evaluate(expr, o);
		System.out.println("andArray:" + result);

	}

	@Test
	public void eqsArray() throws ParseException {

		// 从配置中直接读取
		String expr = "eqsArray(a)";

		// 从通过配置动态获取
		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", new String[] { "aa", "aa" });
		Object result = equationUtil.evaluate(expr, o);
		System.out.println("eqsArray:" + result);

	}

	@Test
	public void eqs() throws ParseException {

		// 从配置中直接读取
		String expr = "eqs(a,b)";

		// 从通过配置动态获取
		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", "a");
		o.put("b", "a");
		Object result = equationUtil.evaluate(expr, o);
		System.out.println("eqs:" + result);

	}

	@Test
	public void in() throws ParseException {

		// 从配置中直接读取
		String expr = "in(a,b)";

		// 从通过配置动态获取
		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", "aa");
		o.put("b", new String[] { "aa", "bb" });
		Object result = equationUtil.evaluate(expr, o);
		System.out.println("in:" + result);

	}

	@Test
	public void notIn() throws ParseException {

		// 从配置中直接读取
		String expr = "notIn(a,b)";

		// 从通过配置动态获取
		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", "aa");
		o.put("b", new String[] { "aa", "bb" });
		Object result = equationUtil.evaluate(expr, o);
		System.out.println("notIn:" + result);

	}

	@Test
	public void f() throws ParseException {

		// 从配置中直接读取
		String expr = "sum(a)";

		// 从通过配置动态获取
		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", new double[] { 1, 2, 3, 4, 5 });

		Object result = equationUtil.evaluate(expr, o);
		System.out.println(result);

	}

	@Test
	public void toStep() throws ParseException {
		String str = "(a+b>0)||(c<0) =>1; eqs(d,e)=>2";
		String[] cons = str.split(";");
		int step = 0;
		String[] splitStr;
		String expr = "";
		Boolean result = null;
		// 从通过配置动态获取
		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", 1);
		o.put("b", 1);
		o.put("c", 1);
		o.put("d", "a");
		o.put("e", "a");
		for (String con : cons) {
			splitStr = con.split("=>");
			expr = splitStr[0];
			result = (Boolean) equationUtil.evaluate(expr, o);
			step = Integer.parseInt(splitStr[1]);
			if (result) {
				System.out.println("toStep:" + step);
			}
		}
	}

	@Test
	public void q() throws ParseException {

		String expr = "count(gt(a,0))";

		Map<String, Object> o = new HashMap<String, Object>();
		o.put("a", new double[] { 1, 2, 3, 4, 5 });

		Object result = equationUtil.evaluate(expr, o);
		System.out.println(result);
	}

	@Test
	public void r() throws ParseException {

		// 多个表达式中的变量名不可重复
		Equation condition = EquationParser.parse("sin(a)");

		Equation condition2 = EquationParser.parse("b + c");
		Expression expr = condition2.getExpression();

		ExpressionCombiner combiner = new ExpressionCombiner();
		Expression exprResult = combiner.replace(condition, "a", expr);

		exprResult.getVariable("b").setValue(1);
		exprResult.getVariable("c").setValue(2);

		System.out.println(condition.eval());
	}

}
