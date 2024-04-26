*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${BROWSER}      chrome
${URL}          https://www.koudaizy.com/
${ACCOUNT}      xxxxxxxxxxxxxx
${PASSWORD}     xxxxxxxxxxxxxx


*** Test Cases ***
Open koudaizy And Sign Up Every Day
    Open Browser    ${URL}    ${BROWSER}
    Click Link    登录
    Wait Until Page Contains    账号    timeout=10s
    Input Text    name=username    ${ACCOUNT}
    Sleep    1s
    Input Text    name=password    ${PASSWORD}
    Click Element    css=.btn-dark.w-100.go-login
    Wait Until Page Contains    中文市场最大的独立英文课程下载网站    timeout=10s
    Sleep    5s
    Click Link    css=.rounded-circle.d-flex.align-items-center
    Wait Until Page Contains    元钱包    timeout=10s
    Sleep    5s

    # 点击签到按钮
    Click Element    class=go-user-qiandao
    # 点击“我的余额”
    Click Link    xpath=//a[@class='nav-link' and @href='https://www.koudaizy.com/user/coin']
    Sleep    10s
    Close Browser
