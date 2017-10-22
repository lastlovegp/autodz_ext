<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign actionName= uiDto.actionName?default('')>
<#assign dateStr= uiDto.dateStr?default('')>
<#assign packageName= uiDto.packageName?default('')>
<@Ctg.page title="${uiDto.code}-信号分析">
<body>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div>
</body>

<script type="text/javascript">
		Ext.onReady(function(){
								    				
	    // 使用
        require(
            [
                'echarts',
                'echarts/chart/line',  
                'echarts/chart/k'
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
                                
                var option = {
							     tooltip : {
							     trigger: 'axis',
							        formatter: function (params) {
							            var res = params[0].name;
							            for (var i = params.length - 1; i >= 0; i--) {
							                if (params[i].value instanceof Array) {
							                    res += '<br/>' + params[i].seriesName;
							                    res += '<br/>  开盘 : ' + params[i].value[0] + '  最高 : ' + params[i].value[3];
							                    res += '<br/>  收盘 : ' + params[i].value[1] + '  最低 : ' + params[i].value[2];
							                }
							                else {
							                    res += '<br/>' + params[i].seriesName;
							                    res += ' : ' + params[i].value;
							                }
							            }
							            return res;
							        }
							    },
							    legend: {
							         data:['zf','${uiDto.code}']
							    },
							     toolbox: {
							        show : true,
							        feature : {							           
							            dataZoom : {show: true},
							            dataView : {show: true, readOnly: false},							           
							            restore : {show: true},
							            saveAsImage : {show: true}
							        }
							    },
							    dataZoom : {
							        show : true,
							        realtime: true,
							        start : 0,
							        end : 200
							    },
							    xAxis : [
							        {
							            type : 'category',
							            boundaryGap : true,
							            axisTick: {onGap:false},
							            splitLine: {show:false},
							            data : ${dateStr}
							        }
							    ],
							    yAxis : [							      
							        {
							            type : 'value',
							            scale:true,							            
							            boundaryGap: [0.01, 0.01]							            
							        },
							        {
							            type : 'value',
							            scale:true,							            
							            boundaryGap: [0.01, 0.01]							            
							        }
							    ],
							    series : [
								 {
						            name:'zf',
						            type:'line',
						            clickable:false,
						            yAxisIndex: 1,
						            symbol: 'none',
						            data : ${uiDto.zfStr}						           
						        },							         					  
							    {
						            name:'${uiDto.code}',
						            type:'k',
						            clickable:false,
						            barMaxWidth: 20,
						            itemStyle: {
						                normal: {
						                    color: 'red',           // 阳线填充颜色
						                    color0: 'lightgreen',   // 阴线填充颜色
						                    lineStyle: {
						                        width: 2,
						                        color: 'orange',    // 阳线边框颜色
						                        color0: 'green'     // 阴线边框颜色
						                    }
						                },
						                emphasis: {
						                    color: 'black',         // 阳线填充颜色
						                    color0: 'white'         // 阴线填充颜色
						                }
						            },
						            data : ${uiDto.valuesStr},
						            markPoint : {						            							               
						                symbolSize:5,
						                clickable:true,
						                itemStyle:{
						                    normal:{label:{position:'top'}}
						                },						              				               							               
						                data : ${uiDto.rtnTranString}
						            }
					        	}
						    ]
						};
							                    
        
	                // 为echarts对象加载数据 
	                myChart.setOption(option); 	                	              
	                
	                var ecConfig = require('echarts/config');
					myChart.on(ecConfig.EVENT.CLICK, eConsole);
			        function eConsole(param) {
			            mes =param.data.xAxis;
			            var type = 0;
			            if (param.type == 'click') {
			                //alert(param.data.value+","+param.data.name);			               
			                if (param.data.name.indexOf('卖出') != -1) {
			                  type = 1;
			                }
			                //window.open('minBarFx_gpMonitor_base.do?code=${uiDto.code}&tdate='+param.data.xAxis,'[${uiDto.code}]一分钟BAR信号分析');
			                window.open('zhibiao_gpMonitor_base.do?code=${uiDto.code}&type='+type+'&date='+param.data.xAxis,'[${uiDto.code}]指标详解');			                
			            }
			        } 
                
                
            }
        );
	
	
	});
                
    </script>

</@Ctg.page>
