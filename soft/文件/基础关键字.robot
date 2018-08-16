*** Settings ***
Library           Selenium2Library
Library           DateTime
Library           DatabaseLibrary
Library           Collections
Library           String
Library           RequestsLibrary
Library           XML
Library           ExcelLibrary
Library           OperatingSystem
Library           BuiltIn
Library           String
Library           Process
Library           Dialogs
Library           Screenshot
Library           Telnet

*** Keywords ***
退出驱动
    evaluate    os.system('taskkill /f /im firefox.exe')    os
    evaluate    os.system('taskkill /f /im chrome.exe')    os
    evaluate    os.system('taskkill /f /im iexplore.exe')    os
    #运行用例前，关闭所有的 浏览器（ie，火狐，谷歌）
    evaluate    os.system('taskkill /f /im IEDriverServer.exe')    os
    evaluate    os.system('taskkill /f /im chromedriver.exe')    os
    evaluate    os.system('taskkill /f /im geckodriver.exe')    os
    #运行完毕后关闭浏览器 的驱动 （ie和谷歌）

关闭进程
    evaluate    os.system('taskkill /f /im firefox.exe')    os
    #evaluate    os.system('taskkill /f /im chrome.exe')    os
    evaluate    os.system('taskkill /f /im iexplore.exe')    os
    #运行用例前，关闭所有的 浏览器（ie，火狐，谷歌）

打开浏览器
    [Arguments]    ${url}    ${browser}
    open browser    ${url}    ${browser}
    Maximize Browser Window
    reload page
    #打开浏览器    参数${url}:是网址    参数${browser}：是浏览器 （ie，gc）

刷新网页
    reload page    #刷新网页

关闭浏览器
    sleep    2
    close browser
    #关闭浏览器

关闭所有浏览器
    close all browsers
    #关闭所有浏览器

点击元素
    [Arguments]    ${locator}
    等待元素出现    ${locator}
    focus    ${locator}
    click element    ${locator}
    #参数${locator}：是定位 方式    例如：id:kw

点击列表
    [Arguments]    ${locator}    ${number}
    #等待元素出现    ${locator}
    @{x}    get webelements    ${locator}
    focus    @{x}[${number}]
    click element    @{x}[${number}]
    #参数${locator}：是定位 方式    参数：${number}是要点击的 第几个元素，的索引值

点击按钮
    [Arguments]    ${locator}
    等待元素出现    ${locator}
    focus    ${locator}
    click button    ${locator}
    #参数${locator}：是 定位方式

点击链接
    [Arguments]    ${locator}
    等待元素出现    ${locator}
    focus    ${locator}
    click link    ${locator}
    #参数${locator}：是定位 方式

双击
    [Arguments]    ${locator}
    等待元素出现    ${locator}
    focus    ${locator}
    double click element    ${locator}
    #参数${locator}：是定位 方式

输入文本
    [Arguments]    ${locator}    ${text}
    等待元素出现    ${locator}
    clear element text    ${locator}
    input text    ${locator}    ${text}
    #参数${locator}：是定位 方式    参数${text}：是要输入的文本

输入文本列表
    [Arguments]    ${locator}    ${index}    ${text}
    #等待元素出现    ${locator}
    等待    2
    @{x}    get webelements    ${locator}
    focus    @{x}[${index}]
    input text    @{x}[${index}]    ${text}
    press key    @{x}[${index}]    \\13
    #参数${locator}：是定位 方式    参数${text}：是要输入的文本

ie输入文本
    [Arguments]    ${locator}    ${text}
    等待元素出现    ${locator}
    ${t1}    get current date
    assign id to element    ${locator}    ${t1}
    execute javascript    window.document.getElementById('${t1}').value='${text}'
    #js定位是使用css定位的    参数${locator}:是定位方式    参数${text}：是要输入的文本

点击radio
    [Arguments]    ${group_name}    ${value}
    wait until page contains element    ${group_name}    10    page not contains element
    select radio button    ${group_name}    ${value}
    #参数${group_name}：是 标签下name的值    参数${value}：是标签下value 的值
    #点击小圆圈

点击checkbox
    [Arguments]    ${locator}
    等待元素出现    ${locator}
    select checkbox    ${locator}
    #参数${locator}为定位方式

下拉框
    [Arguments]    ${locator}    ${value}
    等待元素出现    ${locator}
    focus    ${locator}
    select from list by value    ${locator}    ${value}
    #参数${locator}：是定位 方式    参数${value}：是标签option中 \ value的值
    #点击列表下拉框

下拉框index
    [Arguments]    ${locator}    ${index}
    等待元素出现    ${locator}
    focus    ${locator}
    select from list by index    ${locator}    ${index}
    #参数${locator}：是定位 方式    参数${index}：是标签option索引值
    #点击列表下拉框

jq点击
    [Arguments]    ${x}
    等待元素出现    css:${x[1:-1]}
    focus    css:${x[1:-1]}
    execute javascript    $(${x}).click()
    #jq定位是使用css定位的    参数${x}:是定位的后半部分
    #例如：'#kw',必须使用 引号括起来    不用写'css:'或者'css='

jq双击
    [Arguments]    ${x}
    等待元素出现    css:${x[1:-1]}
    focus    css:${x[1:-1]}
    execute javascript    $(${x}).dblclick()
    #jq定位是使用css定位的    参数${x}:是定位的后半部分
    #例如：'#kw',必须使用 引号括起来    不用写'css:'或者'css='

jq输入
    [Arguments]    ${x}    ${y}
    等待元素出现    css:${x[1:-1]}
    focus    css:${x[1:-1]}
    execute javascript    $(${x}).val('${y}')
    #jq定位是使用css定位的    参数${x}:是定位的后半部分    参数${y}是要输入的文本
    #例如：'#kw',必须使用 引号括起来    不用写'css:'或者'css='

js点击
    [Arguments]    ${x}
    等待元素出现    css:${x[1:-1]}
    focus    css:${x[1:-1]}
    execute javascript    document.querySelectorAll(${x})[0].click()
    #js定位是使用css定位的    参数${x}:是定位的后半部分
    #例如：'#kw',必须使用 引号括起来    不用写'css:'或者'css='

js点击1
    [Arguments]    ${x}    ${y}
    等待元素出现    css:${x[1:-1]}
    focus    css:${x[1:-1]}
    execute javascript    document.querySelectorAll(${x})[${y}].click()
    #js定位是使用css定位的    参数${x}:是定位的后半部分    参数${y}是要点击的第几个数字
    #例如：'#kw',必须使用 引号括起来    不用写'css:'或者'css='

js输入
    [Arguments]    ${locator}    ${text}
    等待元素出现    ${locator}
    ${t1}    get current date
    assign id to element    ${locator}    ${t1}
    execute javascript    window.document.getElementById('${t1}').value='${text}'
    #js定位是使用css定位的    参数${locator}:是定位方式    参数${text}：是要输入的文本

js输入1
    [Arguments]    ${locator}    ${index}    ${text}
    #等待元素出现    ${locator}
    execute javascript    document.querySelectorAll(${locator})[${index}].value='${text}'
    #js定位是使用css定位的    参数${locator}:是定位方式    参数${text}：是要输入的文本

div滚动条
    [Arguments]    ${x}    ${number}
    等待元素出现    css:${x[1:-1]}
    focus    css:${x[1:-1]}
    execute javascript    document.querySelector(${x}).scrollTop=${number}
    #js定位是使用css定位的    参数${x}:是定位的后半部分    参数${number}：是滚动的位置 ，输入的值
    #例如：'#kw',必须使用引号 括起来    不用写'css:'或者'css='

div滚动条left
    [Arguments]    ${x}    ${number}
    等待元素出现    css:${x[1:-1]}
    focus    css:${x[1:-1]}
    execute javascript    document.querySelector(${x}).scrollLeft=${number}
    #js定位是使用css定位的    参数${x}:是定位的后半部分    参数${number}：是滚动的位置 ，输入的值
    #例如：'#kw',必须使用引号 括起来    不用写'css:'或者'css='

滚动条
    [Arguments]    ${x}
    execute javascript    document.documentElement.scrollTop=${x}

打开新页面
    [Arguments]    ${url}
    sleep    3
    execute javascript    window.open('${url}')
    #打开新的网址，参数${url} ：是网址

切换frame
    [Arguments]    ${locator}
    等待元素出现    ${locator}
    focus    ${locator}
    select frame    ${locator}
    #切换到frame框，    参数${locator}：是定位方式，
    #如果有id和name的话直接写： 两个属性的值即可    例如id=kw，name=su，直接写 kw或su即可

返回frame
    Unselect Frame
    #返回主frame

得到窗口
    sleep    3
    @{x}    get window handles
    #得到当前所有窗口句柄的 列表    并将@{x}的值返回
    [Return]    @{x}

切换窗口
    [Arguments]    ${x}    ${y}
    ${z}    evaluate    [list(set(${x})-set(${y}))[0] if len(${x}) > len(${y}) else list(set(${y})-set(${x}))[0]]
    sleep    3
    select window    ${z[0]}
    maximize browser window
    #要跳转到第三个窗口    输入三个窗口的列表和两个窗口 的列列表
    #两个列表的前后没有关系

回到主窗口
    sleep    2
    select window    main
    #返回第一个页面

跳到新窗口
    sleep    2
    select window    new
    #跳转到新窗口

窗口最大化
    maximize browser window

关闭窗口
    close window
    #关闭当前窗口

检查点
    [Arguments]    ${locator}    ${text}    ${message}=error
    等待元素出现    ${locator}
    focus    ${locator}
    ${x}    get text    ${locator}
    log    ${x}    #打印实际结果
    log    ${text}    #打印预期结果
    should contain    ${x}    ${text}    msg=${message}
    #验证文本参数${locator} 为定位方式    参数${text}：是要输入的文本

得到文本
    [Arguments]    ${locator}
    等待元素出现    ${locator}
    focus    ${locator}
    ${x}    get text    ${locator}
    #得到页面中的文本    参数${locator}：是定位方式    最后将文本${x}返回
    [Return]    ${x}

得到长度
    [Arguments]    ${x}
    ${y}    Get Length    ${x}
    [Return]    ${y}

得到属性
    [Arguments]    ${locator}    ${name}
    等待元素出现    ${locator}
    focus    ${locator}
    ${atrr}    Selenium2Library.Get Element Attribute    ${locator}    ${name}
    [Return]    ${atrr}

连接字符串
    [Arguments]    ${str1}    ${str2}
    ${text}    Catenate    ${str1}    ${str2}
    ${x}    Set Variable    ${text.replace(' ','')}
    [Return]    ${x}

得到所有元素
    [Arguments]    ${locator}
    wait until page contains element    ${locator}    10    page not contains element
    @{element}    Get WebElements    ${locator}
    [Return]    @{element}

rf输入时间
    [Arguments]    ${locator}    ${number}
    ${t1}    get current date
    ${t2}    add time to date    ${t1}    ${number}days
    等待元素出现    ${locator}
    focus    ${locator}
    assign id to element    ${locator}    ${t1}
    execute javascript    window.document.getElementById('${t1}').value='${t2[0:10]}'
    #给input标签输入日期    参数${locator} 是：定位方式    参数${number}：是给当前时间 加或减少的天数
    #增加3天：输入数字3即可    减少3天：输入-3即可

py输入时间
    [Arguments]    ${x}    ${y}    ${z}    ${d}
    import library    d:/robot/py/date.py
    ${t1}    evaluate    int(${d})
    ${t2}    date    ${y}    ${z}    ${t1}
    等待元素出现    ${x}
    ${t3}    get current date
    assign id to element    ${x}    ${t3}
    execute javascript    window.document.getElementById('${t3}').value='${t2}'
    #给input标签输入日期    参数${x}是定位方式    参数${y}是：是否判断周末 判断输入yes，不判断输入no    ${d}:增减的天数
    #${z},增加日期输入+ 减少日期输入-    参数${d}是要减少或增加的天数

py输入礼拜四
    [Arguments]    ${locator}
    import library    d:/robot/py/date1.py
    ${t1}    date1
    等待元素出现    ${locator}
    ${t2}    get current date
    assign id to element    ${locator}    ${t2}
    execute javascript    window.document.getElementById('${t2}').value='${t1}'
    #参数${locator}是输入框的 定位方式

数据
    [Arguments]    ${x}    ${y}
    import library    ${x}/read.py
    @{z}    read    ${x}    ${y}
    #读取excel的数据    参数${x}为：excel存放地址    参数${y}：为excel的名字
    [Return]    @{z}

读取excel数据
    [Arguments]    ${name}
    ${x}    Set Variable    ${CURDIR}
    ${x1}    Set Variable    ${x.split('\word')[0]}
    ${excel_address}    连接字符串    ${x1}    \\data\\${name}.xlsx    #得到excel存放地址
    #log    ${excel_address}
    ${py}    连接字符串    ${x1}    \\py\\read_excel.py    #得到读取excel脚本的地址
    #log    ${py}
    import library    ${py}    #引入脚本的函数
    @{z}    read_excel    ${excel_address}
    Set Global Variable    ${data}    ${z}
    #读取excel的数据    参数${x}为：excel存放地址    参数${y}：为excel的名字

用户字典
    import library    d:/robot/data/user.py
    @{x}    user
    set global variable    @{user_data}    @{x}

取消隐藏
    [Arguments]    ${x}
    等待元素出现    css:${x[1:-1]}
    focus    css:${x[1:-1]}
    execute javascript    document.querySelectorAll(${x})[0].style.type="text"
    #js定位是使用css定位的    参数${x}:是定位的后半部分
    #例如：'#kw',必须使用 引号括起来    不用写'css:'或者'css='

结束打开报告
    打开浏览器    file:///D:/robot/report/log.html    gc
    reload page
    打开新页面    file:///D:/robot/report/report.html
    reload page
    evaluate    os.system('taskkill /f /im IEDriverServer.exe')    os
    evaluate    os.system('taskkill /f /im chromedriver.exe')    os

等待
    [Arguments]    ${x}
    sleep    ${x}
    #参数${number}为输入 的秒数

等待元素出现
    [Arguments]    ${locator}
    wait until page contains element    ${locator}    10    page not contains element
    wait until element is visible    ${locator}    10    element is not visible
    #参数${locator}为定位方式

回车
    [Arguments]    ${locator}
    press key    ${locator}    \\13

解压文件
    [Arguments]    ${x}    ${y}
    evaluate    os.system("WinRAR x ${x} ${y}")    os

点击弹框
    confirm action    #点击弹框中的确定

HR用户名
    [Arguments]    ${x}
    [Documentation]    参数${x}输入人员，中文姓名
    import library    d:/robot/py/read_oracle.py
    ${user}    read_oracle    select USER_NOTESNAME,USER_SHORTNAME from v_emp where USER_NOTESNAME=    ${x}
    [Return]    ${user}

鼠标悬停
    [Arguments]    ${locator}
    等待元素出现    ${locator}
    Mouse Over    ${locator}

得到当前网址
    ${url}    Get Location
    [Return]    ${url}

Common_Test_Setup
    [Arguments]    ${TEST NAME}    ${OUTPUT DIR}
    [Timeout]    10 minutes
    #change log level for debug
    Set Log Level    TRACE
    #set log to custome path
    Create List

Common_Test_Teardown
    OperatingSystem.Run    echo “${TEST_NAME}:${TEST_STATUS}:${TEST MESSAGE}” >> D:/robot/report/International-B2B/001demo.txt
    #OperatingSystem.Run    echo “${Suite_NAME}:${Suite_STATUS}:${SuiteMESSAGE}” >> D:/robot/report/International-B2B/001demo.txt
