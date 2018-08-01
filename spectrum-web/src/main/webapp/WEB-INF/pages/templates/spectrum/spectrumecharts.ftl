<#macro content>
<div id="main" style="width: 600px;height:400px;"></div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    $.ajax({
        type: "POST",//请求方式
        url: "2.json",//地址，就是json文件的请求路径
        dataType: "json",
        success: function (data, status) {

            myChart.setOption(option = {
                title: {
                    text: 'spectrum'
                },
                tooltip: {
                    trigger: 'axis'
                },
                xAxis: {
                    data: data.points.map(function (item) {
                        console.log(data);
                        return item.x;
                    })
                },
                yAxis: {
                    splitLine: {
                        show: false
                    }
                },
                toolbox: {
                    left: 'center',
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        restore: {},
                        saveAsImage: {}
                    }
                },
                dataZoom: [{
                    startValue: data.points[0].x
                }, {
                    type: 'inside'
                }],
                /*visualMap: {
                    top: 10,
                    right: 10,
                    pieces: [{
                        gt: 0,
                        lte: 50,
                        color: '#096'
                    }, {
                        gt: 50,
                        lte: 100,
                        color: '#ffde33'
                    }, {
                        gt: 100,
                        lte: 150,
                        color: '#ff9933'
                    }, {
                        gt: 150,
                        lte: 200,
                        color: '#cc0033'
                    }, {
                        gt: 200,
                        lte: 300,
                        color: '#660099'
                    }, {
                        gt: 300,
                        color: '#7e0023'
                    }],
                    outOfRange: {
                        color: '#999'
                    }
                },*/
                series: {
                    name: 'spectrum',
                    type: 'line',
                    data: data.points.map(function (item) {
                        console.log(item.y);
                        return item.y;
                    }),
                   /* markLine: {
                        silent: true,
                        data: [{
                            yAxis: 50
                        }, {
                            yAxis: 100
                        }, {
                            yAxis: 150
                        }, {
                            yAxis: 200
                        }, {
                            yAxis: 300
                        }]
                    }*/
                }
            });

        }
    });

</script>
</#macro>