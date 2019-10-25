/*
The MIT License (MIT)

Copyright (c) 2017 Parto Pardazesh Fartak(IRANAPEX)
Saeed Hassanpour
www.iranapex.ir
www.translate-apex.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


DECLARE
  v_workspace_name VARCHAR2(100) := 'MY_WORKSPACE_NAME'; -- APEX Workspace Name
  v_app_id NUMBER := MY_APP_ID; -- APEX Application ID e.g. 134
  v_session_id NUMBER := 1; -- APEX session ID (doesn't matter)

  v_workspace_id apex_workspaces.workspace_id%type;

BEGIN 
-- Get workspace ID by its name
  select 
    workspace_id
  into 
    v_workspace_id
  from 
    apex_workspaces
  where 
    upper(workspace) = upper(v_workspace_name);

-- Set APEX workspace ID
  apex_util.set_security_group_id(v_workspace_id);

-- Set APEX application ID
  apex_application.g_flow_id := v_app_id; 

-- Set APEX session ID
  apex_application.g_instance := v_session_id; 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RICH_TEXT_EDITOR.ACCESSIBLE_LABEL'
,p_message_language=>'fa'
,p_message_text=>'%0 , ویرایشگر متن غني'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.CHART'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از اين پنجره و تعريف يک نمودار مي توان در يک پنجره مجزا آنرا مشاهده کرد.<br>',
'يک نمودار را انتخاب کنيد و سپس تنظيمات مربوط به آنرا انجام دهيد و بر روي <strong>ذخيره</strong> کليک کنيد</p>',
'<p><strong>تنظيمات نمودار</strong></p>',
'<p>ويژگي هاي نمودار بستگي به نوع نمودار دارد.خيلي از ويژگي ها را مي توان براي انواع نمودار ها تعريف کرد. ويژگي هايي که با يک ستاره قرمز مشخص شده است اجباري مي باشد</p>',
'<p> در زير تمام ويژگي ها براي انواع مختلف نمودار ها هستند (به ترتيب حروف الفبا):',
'<ul>',
'<li>تجميع کردن- انتخاب کنيد که چگونه تجميع کنيد که مرتبط با مقادير نمودار باشد</li>',
'<li>بستن - انتخاب ستوني که حاوي سهام روزانه قيمت براي بستن مبلغ مي باشد(فقط براي نمودار سهام)</li>',
'<li>دهدهي - تعداد رقم اعشار را وارد کنيد که مقادير گرد شود</li>',
'<li>جهت - در رابطه با مرتب کردن بر اساس ويژگي، مشخص کنيد که آيا داده ها به ترتيب صعودي يا نزولي ارزش طبقه بندي شوند</li>',
'<li> بالا - ستوني که حاوي مقدار بالا (فقط براي محدوده نمودار سهام) انتخاب کنيد</li>',
'<li> برچسب - ستوني که شامل متن براي هر نقطه داده را انتخاب کنيد</li>',
'<li> برچسب عنوان محور - عنواني که در محور برچسب نمايش داده مي شود را وارد کنيد</li>',
'<li> پايين - ستوني که حاوي مقدار پايين (فقط براي محدوده نمودار سهام) انتخاب کنيد</li>',
'<li> تهي - در رابطه با مرتب کردن بر اساس ويژگي، مشخص کنيد که چگونه مي خواهيد رديف ها با مقادير پوچ در ارتباط با رديف ها با مقادير غير پوچ طبقه بندي شوند</li>',
'<li> باز - ستوني که حاوي قيمت افتتاحيه سهام روزانه (فقط نمودار سهام) را انتخاب کنيد</li>',
'<li> جهت - اينکه آيا عناصر نمودار، مانند ميله، بصورت نمايش افقي يا عمودي باشد را انتخاب کنيد</li>',
'<li> سلسه - ستون مورد استفاده براي تعريف چند سلسه کوئري هاي پوياي خود را انتخاب کنيد</li>',
'<li>پشته(Stack) - مشخص کنيد که آيا اقلام داده انباشته مي شوند</li>',
'<li>مرتب کردن بر اساس - انتخاب کنيد که آيا جدول توسط برچسب يا مقادير مرتب شوند</li>',
'<li>هدف – ستوني که براي تعريف مقدار هدف در اين جدول استفاده مي شود را انتخاب کنيد. هنگامي که مجموعه، ويژگي هاي مقدار در ناحيه پر بصورت تکه اي تعريف مي شود و هدف نشان دهنده مقداري از طيف تکه مي باشد (فقط نمودار قيف)</li>',
'<li> مقدار - ستون حاوي داده هايي که رسم ميشود را انتخاب کنيد</li>',
'</ul></p>',
''))
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ASCENDING'
,p_message_language=>'fa'
,p_message_text=>'صعودی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AUTHORIZATION'
,p_message_language=>'fa'
,p_message_text=>'مجاز'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AUTO'
,p_message_language=>'fa'
,p_message_text=>'اتوماتیک'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AVG'
,p_message_language=>'fa'
,p_message_text=>'میانگین'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AXIS_LABEL_TITLE'
,p_message_language=>'fa'
,p_message_text=>'عنوان محور برچسب نمودار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AXIS_VALUE_DECIMAL'
,p_message_language=>'fa'
,p_message_text=>'رقم اعشار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AXIS_VALUE_TITLE'
,p_message_language=>'fa'
,p_message_text=>'عنوان محور مقدار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.BACKGROUND_COLOR'
,p_message_language=>'fa'
,p_message_text=>'رنگ زمینه'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.BAR'
,p_message_language=>'fa'
,p_message_text=>'میله ای (Bar)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.BETWEEN'
,p_message_language=>'fa'
,p_message_text=>'بین'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.BOTH'
,p_message_language=>'fa'
,p_message_text=>'هردو'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.BUBBLE'
,p_message_language=>'fa'
,p_message_text=>'حبابی (Bubble)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CANCEL'
,p_message_language=>'fa'
,p_message_text=>'انصراف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CASE_SENSITIVE'
,p_message_language=>'fa'
,p_message_text=>'حساس به حروف کوچک و بزرگ'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CASE_SENSITIVE_WITH_BRACKETS'
,p_message_language=>'fa'
,p_message_text=>'(حساس به حروف کوچک و بزرگ)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CHANGES_SAVED'
,p_message_language=>'fa'
,p_message_text=>'تغییرات ذخیره شد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CHANGE_VIEW'
,p_message_language=>'fa'
,p_message_text=>'نمایش تغییرات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CHART'
,p_message_language=>'fa'
,p_message_text=>'نمودار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CHART_VIEW'
,p_message_language=>'fa'
,p_message_text=>'نمایش نمودار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CLOSE_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'بستن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLORS'
,p_message_language=>'fa'
,p_message_text=>'رنگها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLOR_BLUE'
,p_message_language=>'fa'
,p_message_text=>'آبی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLOR_GREEN'
,p_message_language=>'fa'
,p_message_text=>'سبز'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLOR_ORANGE'
,p_message_language=>'fa'
,p_message_text=>'نارنجی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLOR_RED'
,p_message_language=>'fa'
,p_message_text=>'قرمز'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLOR_YELLOW'
,p_message_language=>'fa'
,p_message_text=>'زرد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLUMN'
,p_message_language=>'fa'
,p_message_text=>'ستون'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLUMNS'
,p_message_language=>'fa'
,p_message_text=>'ستون ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLUMN_CONTEXT'
,p_message_language=>'fa'
,p_message_text=>'ستون %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COLUMN_TYPE'
,p_message_language=>'fa'
,p_message_text=>'هدف ستون'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COMPLEX'
,p_message_language=>'fa'
,p_message_text=>'پیچیده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COMPUTE'
,p_message_language=>'fa'
,p_message_text=>'محاسبه کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CONTAINS'
,p_message_language=>'fa'
,p_message_text=>'محتویات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CONTROL_BREAK'
,p_message_language=>'fa'
,p_message_text=>'جدا کننده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COUNT'
,p_message_language=>'fa'
,p_message_text=>'تعداد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COUNT_DISTINCT'
,p_message_language=>'fa'
,p_message_text=>'تعداد متمایز'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COUNT_DISTINCT_OVERALL'
,p_message_language=>'fa'
,p_message_text=>'تعداد متمایز بطور کلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.COUNT_OVERALL'
,p_message_language=>'fa'
,p_message_text=>'تعداد بطور کلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.CREATE_X'
,p_message_language=>'fa'
,p_message_text=>'ایجاد شد %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DATA'
,p_message_language=>'fa'
,p_message_text=>'اطلاعات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DATA_TYPE'
,p_message_language=>'fa'
,p_message_text=>'نوع اطلاعات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DATE'
,p_message_language=>'fa'
,p_message_text=>'تاریخ'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DAYS'
,p_message_language=>'fa'
,p_message_text=>'روزها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DEFAULT_SETTINGS'
,p_message_language=>'fa'
,p_message_text=>'تنظیمات پیش فرض'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DEFAULT_TYPE'
,p_message_language=>'fa'
,p_message_text=>'نوع تنظیمات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DELETE'
,p_message_language=>'fa'
,p_message_text=>'حذف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DELETE_REPORT_CONFIRM'
,p_message_language=>'fa'
,p_message_text=>'آیا شما مطمئن هستید که می خواهید این گزارش را حذف کنید؟'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DELETE_ROW'
,p_message_language=>'fa'
,p_message_text=>'حذف ردیف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DELETE_ROWS'
,p_message_language=>'fa'
,p_message_text=>'حذف ردیف ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DESCENDING'
,p_message_language=>'fa'
,p_message_text=>'نزولی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DETAIL'
,p_message_language=>'fa'
,p_message_text=>'جزئیات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DETAIL_VIEW'
,p_message_language=>'fa'
,p_message_text=>'نمایش جزئیات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DIRECTION'
,p_message_language=>'fa'
,p_message_text=>'جهت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DISABLED'
,p_message_language=>'fa'
,p_message_text=>'غیرفعال'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DOES_NOT_CONTAIN'
,p_message_language=>'fa'
,p_message_text=>'محتوی وجود ندارد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DOES_NOT_START_WITH'
,p_message_language=>'fa'
,p_message_text=>'شروع نشد با'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DONUT'
,p_message_language=>'fa'
,p_message_text=>'حلقه ای(Donut)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DOWNLOAD'
,p_message_language=>'fa'
,p_message_text=>'دانلود'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DOWNLOAD_FORMAT'
,p_message_language=>'fa'
,p_message_text=>'انتخاب فرمت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DUPLICATE_AGGREGATION'
,p_message_language=>'fa'
,p_message_text=>'تکرار تجمیع'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DUPLICATE_CONTROLBREAK'
,p_message_language=>'fa'
,p_message_text=>'تکرار جداکننده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DUPLICATE_ROW'
,p_message_language=>'fa'
,p_message_text=>'تکرار ردیف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.DUPLICATE_ROWS'
,p_message_language=>'fa'
,p_message_text=>'تکرار ردیف ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EDIT'
,p_message_language=>'fa'
,p_message_text=>'ویرایش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EDIT_CHART'
,p_message_language=>'fa'
,p_message_text=>'ویرایش نمودار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EDIT_GROUP_BY'
,p_message_language=>'fa'
,p_message_text=>'ویرایش گروه بندی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EMAIL_BCC'
,p_message_language=>'fa'
,p_message_text=>'کپی نابینا(bcc)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EMAIL_BODY'
,p_message_language=>'fa'
,p_message_text=>'پیغام'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EMAIL_CC'
,p_message_language=>'fa'
,p_message_text=>'کپی (cc)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EMAIL_SENT'
,p_message_language=>'fa'
,p_message_text=>'ایمیل فرستاده شد.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.ACTIVE_STATE'
,p_message_language=>'fa'
,p_message_text=>'(فعال)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.COMBOBOX.LIST_OF_VALUES'
,p_message_language=>'fa'
,p_message_text=>'لیست مقادیر'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.COMBOBOX.SHOW_ALL_VALUES'
,p_message_language=>'fa'
,p_message_text=>'باز شدن لیست برای: %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.COMPLETED_STATE'
,p_message_language=>'fa'
,p_message_text=>'(تکمیل شد)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.CORRECT_ERRORS'
,p_message_language=>'fa'
,p_message_text=>'قبل از ثبت اطلاعات خطاها را اصلاح کنید.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.DIALOG.CANCEL'
,p_message_language=>'fa'
,p_message_text=>'انصراف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.DIALOG.CLOSE'
,p_message_language=>'fa'
,p_message_text=>'بستن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.DIALOG.HELP'
,p_message_language=>'fa'
,p_message_text=>'راهنما'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.DIALOG.OK'
,p_message_language=>'fa'
,p_message_text=>'قبول'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.DIALOG.SAVE'
,p_message_language=>'fa'
,p_message_text=>'ثبت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.ERROR.PAGE_NOT_AVAILABLE'
,p_message_language=>'fa'
,p_message_text=>'با عرض پوزش, این صفحه در دسترس نمی باشد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.ERROR_MESSAGE_HEADING'
,p_message_language=>'fa'
,p_message_text=>'پیغام خطا'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.BREAK_COLLAPSE'
,p_message_language=>'fa'
,p_message_text=>'باز کردن جداکننده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.BREAK_EXPAND'
,p_message_language=>'fa'
,p_message_text=>'بستن جدا کننده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.DELETED_COUNT'
,p_message_language=>'fa'
,p_message_text=>'%0 ردیف حذف شد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.DUP_REC_ID'
,p_message_language=>'fa'
,p_message_text=>'رکورد تکراری است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.FIRST_PAGE'
,p_message_language=>'fa'
,p_message_text=>'اولین'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.LAST_PAGE'
,p_message_language=>'fa'
,p_message_text=>'آخرین'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.LOAD_MORE'
,p_message_language=>'fa'
,p_message_text=>'بارگذاری ردیف های بیشتر'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.NEXT_PAGE'
,p_message_language=>'fa'
,p_message_text=>'بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.PAGE_RANGE_XY'
,p_message_language=>'fa'
,p_message_text=>'%0 - %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.PAGE_RANGE_XYZ'
,p_message_language=>'fa'
,p_message_text=>'%0 - %1 از %2'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.PREV_PAGE'
,p_message_language=>'fa'
,p_message_text=>'قبلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.ROW_ADDED'
,p_message_language=>'fa'
,p_message_text=>'اضافه شده است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.ROW_CHANGED'
,p_message_language=>'fa'
,p_message_text=>'تغییر کرده است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.ROW_DELETED'
,p_message_language=>'fa'
,p_message_text=>'حذف شده است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.SELECTION_COUNT'
,p_message_language=>'fa'
,p_message_text=>'%0 ردیف انتخاب شده است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.SELECT_PAGE_N'
,p_message_language=>'fa'
,p_message_text=>'صفحه 0%'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.SORT_ASCENDING'
,p_message_language=>'fa'
,p_message_text=>'مرتب سازی صعودی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.SORT_ASCENDING_ORDER'
,p_message_language=>'fa'
,p_message_text=>'مرتب سازی صعودی %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.SORT_DESCENDING'
,p_message_language=>'fa'
,p_message_text=>'مرتب سازی نزولی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.SORT_DESCENDING_ORDER'
,p_message_language=>'fa'
,p_message_text=>'مرتب سازی نزولی %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.SORT_OFF'
,p_message_language=>'fa'
,p_message_text=>'مرتب نشده است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.GV.TOTAL_PAGES'
,p_message_language=>'fa'
,p_message_text=>'تعداد کل %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ACC_LABEL'
,p_message_language=>'fa'
,p_message_text=>'Interactive Grid %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ACTIONS'
,p_message_language=>'fa'
,p_message_text=>'عملیات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ADD'
,p_message_language=>'fa'
,p_message_text=>'اضافه'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ADD_ROW'
,p_message_language=>'fa'
,p_message_text=>'اضافه کردن ردیف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AGGREGATE'
,p_message_language=>'fa'
,p_message_text=>'تجمیع کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AGGREGATION'
,p_message_language=>'fa'
,p_message_text=>'تجمیع'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ALL'
,p_message_language=>'fa'
,p_message_text=>'همه'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ALL_TEXT_COLUMNS'
,p_message_language=>'fa'
,p_message_text=>'همه متن ستون ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ALTERNATIVE'
,p_message_language=>'fa'
,p_message_text=>'جایگزین'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AND'
,p_message_language=>'fa'
,p_message_text=>'و'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.APPROX_COUNT_DISTINCT'
,p_message_language=>'fa'
,p_message_text=>'تقریبی. تعداد متمایز'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.APPROX_COUNT_DISTINCT_OVERALL'
,p_message_language=>'fa'
,p_message_text=>'تقریبی بطور کلی. تعداد متمایز'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.AREA'
,p_message_language=>'fa'
,p_message_text=>'ناحیه ای(Area)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.MINUTES_FROM_NOW'
,p_message_language=>'fa'
,p_message_text=>'در %0m'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.MONTHS_AGO'
,p_message_language=>'fa'
,p_message_text=>'%0mo'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.MONTHS_FROM_NOW'
,p_message_language=>'fa'
,p_message_text=>'در %0mo'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.SECONDS_AGO'
,p_message_language=>'fa'
,p_message_text=>'%0s'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.SECONDS_FROM_NOW'
,p_message_language=>'fa'
,p_message_text=>'در %0s'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.WEEKS_AGO'
,p_message_language=>'fa'
,p_message_text=>'%0w'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.WEEKS_FROM_NOW'
,p_message_language=>'fa'
,p_message_text=>'در %0w'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.YEARS_AGO'
,p_message_language=>'fa'
,p_message_text=>'%0y'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.YEARS_FROM_NOW'
,p_message_language=>'fa'
,p_message_text=>'در %0y'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SUCCESS_MESSAGE_HEADING'
,p_message_language=>'fa'
,p_message_text=>'پیغام موفقیت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.TABS.NEXT'
,p_message_language=>'fa'
,p_message_text=>'بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.TABS.PREVIOUS'
,p_message_language=>'fa'
,p_message_text=>'قبلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.TB.TOOLBAR'
,p_message_language=>'fa'
,p_message_text=>'نوار ابزار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.TEMPLATE.EXPAND_COLLAPSE_NAV_LABEL'
,p_message_language=>'fa'
,p_message_text=>'باز کردن/ بستن جهت یابی  (Navigation)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.TEMPLATE.EXPAND_COLLAPSE_SIDE_COL_LABEL'
,p_message_language=>'fa'
,p_message_text=>'باز کردن/ بستن ستون مجاور'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.THEMES.INVALID_THEME_NUMBER'
,p_message_language=>'fa'
,p_message_text=>'تم.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.UI.BACK_TO_TOP'
,p_message_language=>'fa'
,p_message_text=>'شروع از  صفحه'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.VALUE_REQUIRED'
,p_message_language=>'fa'
,p_message_text=>'مقدار اجباری می باشد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.WAIT_UNTIL_PAGE_LOADED'
,p_message_language=>'fa'
,p_message_text=>'لطفا تا زمان بارگذاری کل صفحه منتظر بمانید و دوباره تلاش کنید'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEXIR_DATA'
,p_message_language=>'fa'
,p_message_text=>'داده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEXIR_FILTER_EXPR_TOO_LONG'
,p_message_language=>'fa'
,p_message_text=>'عبارت فیلتر بیش از حد طولانی  می باشد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEXIR_MAP_IT'
,p_message_language=>'fa'
,p_message_text=>'نقشه آن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEXIR_MULTIIR_PAGE_REGION_STATIC_ID_REQUIRED'
,p_message_language=>'fa'
,p_message_text=>'Region Static ID باید در صفحه ای که شامل گزارش های تعاملی متعدد (IR) می باشد مشخص شود'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEXIR_NEW_CATEGORY_LABEL'
,p_message_language=>'fa'
,p_message_text=>'گروه بندی جدید'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEXIR_PIVOT_ROW_COLUMN_INVALID'
,p_message_language=>'fa'
,p_message_text=>'لطفا یک ردیف ستون دیگر را انتخاب کنید. عبارت HTML یا لینک در ردیف ستون شامل ستون بعنوان محوری (Pivot)  یا تجمیع تعریف شده است.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT.Y.MONTHS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 ماه بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT.Y.WEEKS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 هفته بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT.Y.YEARS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 سال بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT_DAY'
,p_message_language=>'fa'
,p_message_text=>'%0 در روز بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT_HOUR'
,p_message_language=>'fa'
,p_message_text=>'%0 در ساعت بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT_MINUTE'
,p_message_language=>'fa'
,p_message_text=>'%0 در دقیقه بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT_MONTH'
,p_message_language=>'fa'
,p_message_text=>'%0 در ماه بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT_WEEK'
,p_message_language=>'fa'
,p_message_text=>'%0 در هفته بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT_YEAR'
,p_message_language=>'fa'
,p_message_text=>'%0 در سال بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IS_NOT_NULL'
,p_message_language=>'fa'
,p_message_text=>'%0 تهی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IS_NULL'
,p_message_language=>'fa'
,p_message_text=>'%0 تهی است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.LESS_THAN.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 کمتر از %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.LESS_THAN_OR_EQUALS.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 کمتر از یا مساوی %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.LIKE.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 شبیه %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.MATCHES_REGULAR_EXPRESSION.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 منطبق با  regular expression %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.MINUTES_AGO'
,p_message_language=>'fa'
,p_message_text=>'%0 دقیقه قبل'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_BETWEEN.Y.AND.Z'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست مابین %1 و  %2'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_EQUALS.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 مساوی نمی باشد با %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 در این مجموعه نیست %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST.Y.DAYS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 روز گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST.Y.HOURS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 ساعت گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST.Y.MINUTES'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 دقیقه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST.Y.MONTHS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 ماه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST.Y.WEEKS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 هفته گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST.Y.YEARS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 سال گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST_DAY'
,p_message_language=>'fa'
,p_message_text=>'%0  در روز گذشته نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST_HOUR'
,p_message_language=>'fa'
,p_message_text=>'%0  در ساعت گذشته نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST_MINUTE'
,p_message_language=>'fa'
,p_message_text=>'%0  در دقیقه گذشته نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST_MONTH'
,p_message_language=>'fa'
,p_message_text=>'%0  در ماه گذشته نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST_WEEK'
,p_message_language=>'fa'
,p_message_text=>'%0  در هفته گذشته نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_LAST_YEAR'
,p_message_language=>'fa'
,p_message_text=>'%0  در سال گذشته نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT.Y.DAYS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 روز بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT.Y.HOURS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 ساعت بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT.Y.MINUTES'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 دقیقه بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT.Y.MONTHS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 ماه بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT.Y.WEEKS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 هفته بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT.Y.YEARS'
,p_message_language=>'fa'
,p_message_text=>'%0 نیست در %1 سال بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT_DAY'
,p_message_language=>'fa'
,p_message_text=>'%0  در روز بعدی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT_HOUR'
,p_message_language=>'fa'
,p_message_text=>'%0  در ساعت بعدی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT_MINUTE'
,p_message_language=>'fa'
,p_message_text=>'%0  در دقیقه بعدی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT_MONTH'
,p_message_language=>'fa'
,p_message_text=>'%0  در ماه بعدی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT_WEEK'
,p_message_language=>'fa'
,p_message_text=>'%0  در هفته بعدی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_IN_THE_NEXT_YEAR'
,p_message_language=>'fa'
,p_message_text=>'%0  در سال بعدی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.NOT_LIKE.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 شبیه نیست با %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.STARTS_WITH.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 شروع شود با %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'X'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.YEARS'
,p_message_language=>'fa'
,p_message_text=>'سال'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.Y_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'Y'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.Z_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'Z'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG_FORMAT_SAMPLE_1'
,p_message_language=>'fa'
,p_message_text=>'سه شنبه, 3 فروردین, 1396'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG_FORMAT_SAMPLE_2'
,p_message_language=>'fa'
,p_message_text=>'فروردین'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG_FORMAT_SAMPLE_3'
,p_message_language=>'fa'
,p_message_text=>'16 ساعت قبل'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG_FORMAT_SAMPLE_4'
,p_message_language=>'fa'
,p_message_text=>'در 16 ساعت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.ITEM.NOT_FOUND'
,p_message_language=>'fa'
,p_message_text=>'آیتم %0  یافت نشد.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.MENU.CURRENT_MENU'
,p_message_language=>'fa'
,p_message_text=>'جاری'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.MENU.OVERFLOW_LABEL'
,p_message_language=>'fa'
,p_message_text=>'بیشتر ...'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.MENU.PROCESSING'
,p_message_language=>'fa'
,p_message_text=>'بارگذاری'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.PROCESSING'
,p_message_language=>'fa'
,p_message_text=>'در حال پردازش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.DELETE'
,p_message_language=>'fa'
,p_message_text=>'حذف کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.EXCLUDE_HIDDEN'
,p_message_language=>'fa'
,p_message_text=>'ستون های نمایش داده شده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.EXCLUDE_NULL'
,p_message_language=>'fa'
,p_message_text=>'مستثنی کردن مقادیر تهی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.INSERT'
,p_message_language=>'fa'
,p_message_text=>'اضافه کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.NEXT_RECORD'
,p_message_language=>'fa'
,p_message_text=>'بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.NOT_GROUPED_LABEL'
,p_message_language=>'fa'
,p_message_text=>'ستون های دیگر'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.PREV_RECORD'
,p_message_language=>'fa'
,p_message_text=>'قبلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.REC_X'
,p_message_language=>'fa'
,p_message_text=>'ردیف %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.REC_XY'
,p_message_language=>'fa'
,p_message_text=>'ردیف %0 از %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.RV.SETTINGS_MENU'
,p_message_language=>'fa'
,p_message_text=>'تنظیمات منو'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.DAYS_AGO'
,p_message_language=>'fa'
,p_message_text=>'%0d'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.DAYS_FROM_NOW'
,p_message_language=>'fa'
,p_message_text=>'در %0d'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.HOURS_AGO'
,p_message_language=>'fa'
,p_message_text=>'%0h'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.HOURS_FROM_NOW'
,p_message_language=>'fa'
,p_message_text=>'در %0h'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.SINCE.SHORT.MINUTES_AGO'
,p_message_language=>'fa'
,p_message_text=>'%0m'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REVERT_ROWS'
,p_message_language=>'fa'
,p_message_text=>'برگرداندن ردیف ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ROW'
,p_message_language=>'fa'
,p_message_text=>'ردیف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ROWS_PER_PAGE'
,p_message_language=>'fa'
,p_message_text=>'ردیف ها در هر صفحه'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ROW_ACTIONS'
,p_message_language=>'fa'
,p_message_text=>'عملیات ردیف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ROW_ACTIONS_FOR'
,p_message_language=>'fa'
,p_message_text=>'عملیات برای ردیف %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ROW_COLUMN_CONTEXT'
,p_message_language=>'fa'
,p_message_text=>'ردیف %0 ستون %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ROW_CONTEXT'
,p_message_language=>'fa'
,p_message_text=>'ردیف %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SAVE'
,p_message_language=>'fa'
,p_message_text=>'ذخیره کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SAVED_REPORTS'
,p_message_language=>'fa'
,p_message_text=>'گزارش ها ذخیره شد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SAVED_REPORT_DEFAULT'
,p_message_language=>'fa'
,p_message_text=>'پیش فرض'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SAVED_REPORT_PRIVATE'
,p_message_language=>'fa'
,p_message_text=>'اصلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SAVED_REPORT_PUBLIC'
,p_message_language=>'fa'
,p_message_text=>'عمومی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SAVE_AS'
,p_message_language=>'fa'
,p_message_text=>'ذخیره کردن بعنوان'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SAVE_REPORT_SETTINGS'
,p_message_language=>'fa'
,p_message_text=>'ذخیره تنظیمات گزارش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SCATTER'
,p_message_language=>'fa'
,p_message_text=>'پراکنده (Scatter)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SEARCH'
,p_message_language=>'fa'
,p_message_text=>'جستجو'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SEARCH.ALL_COLUMNS'
,p_message_language=>'fa'
,p_message_text=>'جستجو : همه متن ستون ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SEARCH.COLUMN'
,p_message_language=>'fa'
,p_message_text=>'جستجو : %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SEARCH.ORACLE_TEXT'
,p_message_language=>'fa'
,p_message_text=>'جستجو : کل متن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SEARCH_FOR.X'
,p_message_language=>'fa'
,p_message_text=>'جستجو برای ''%0'''
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SELECT'
,p_message_language=>'fa'
,p_message_text=>'انتخاب-'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SELECT_1_ROW_IN_MASTER'
,p_message_language=>'fa'
,p_message_text=>'انتخاب یک ردیف در ناحیه برتر'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SELECT_COLUMNS_TO_SEARCH'
,p_message_language=>'fa'
,p_message_text=>'انتخاب ستون ها برای جستجو'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SEL_ACTIONS'
,p_message_language=>'fa'
,p_message_text=>'عملیات انتخاب'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SEND_AS_EMAIL'
,p_message_language=>'fa'
,p_message_text=>'ارسال ایمیل'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SERIES_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'سلسله'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SHOW_OVERALL_VALUE'
,p_message_language=>'fa'
,p_message_text=>'نمایش مقادیر کلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SINGLE_ROW_VIEW'
,p_message_language=>'fa'
,p_message_text=>'نمایش تک ردیفی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SORT'
,p_message_language=>'fa'
,p_message_text=>'مرتب کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SORT_BY'
,p_message_language=>'fa'
,p_message_text=>'مرتب سازی بر اساس'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SORT_ONLY_ONE_PER_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'شما می توانید برای هر ستون فقط یک عمل مرتب سازی تعریف کنید'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SRV_CHANGE_MENU'
,p_message_language=>'fa'
,p_message_text=>'منو تغییرات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.STACK'
,p_message_language=>'fa'
,p_message_text=>'پشته(Stack)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.STARTS_WITH'
,p_message_language=>'fa'
,p_message_text=>'شروع شود با'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.STOCK'
,p_message_language=>'fa'
,p_message_text=>'سهام (Stock)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SUBSCRIPTION'
,p_message_language=>'fa'
,p_message_text=>'اشتراک گذاری'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SUM'
,p_message_language=>'fa'
,p_message_text=>'جمع'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SUMMARY'
,p_message_language=>'fa'
,p_message_text=>'Interactive Grid با %0 ردیف و  %1  ستون. گزارش = %2، دیدن = %3، شروع رکوردهای نمایش داده شده = %4، پایان ردیف های نمایش داده شده = %5'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.SUM_OVERALL'
,p_message_language=>'fa'
,p_message_text=>'جمع کلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.TARGET_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'مقصد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.TEXT_COLOR'
,p_message_language=>'fa'
,p_message_text=>'رنگ متن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.TOGGLE'
,p_message_language=>'fa'
,p_message_text=>'تغییر وضعیت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.TOOLTIP'
,p_message_language=>'fa'
,p_message_text=>'راهنمای ابزار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.TYPE'
,p_message_language=>'fa'
,p_message_text=>'نوع'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.UNFREEZE'
,p_message_language=>'fa'
,p_message_text=>'غیرفعال کردن فریز(ثابت کردن)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.UNIT'
,p_message_language=>'fa'
,p_message_text=>'واحد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.UNSAVED_CHANGES_CONTINUE_CONFIRM'
,p_message_language=>'fa'
,p_message_text=>'تغییرات ذخیره نشده است. آیا شما می خواهید ادامه دهید؟'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.VALUE'
,p_message_language=>'fa'
,p_message_text=>'مقدار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.VALUE_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'مقدار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.VALUE_REQUIRED'
,p_message_language=>'fa'
,p_message_text=>'یک مقدار اجباری می باشد.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.VARCHAR2'
,p_message_language=>'fa'
,p_message_text=>'متن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.VERTICAL'
,p_message_language=>'fa'
,p_message_text=>'عمودی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.VIEW'
,p_message_language=>'fa'
,p_message_text=>'مشاهده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.VISIBLE'
,p_message_language=>'fa'
,p_message_text=>'نمایش داده شده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.VOLUME_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'حجم'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.WEEKS'
,p_message_language=>'fa'
,p_message_text=>'هفته ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.WIDTH'
,p_message_language=>'fa'
,p_message_text=>'حداقل طول ستون(پیکسل)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.BETWEEN.Y.AND.Z'
,p_message_language=>'fa'
,p_message_text=>'%0 بین %1 و  %2'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.CONTAINS.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 شامل می باشد با %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.DOES_NOT_CONTAIN.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 شامل نمی باشد با %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.EQUALS.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 مساوی می باشد با %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.GREATER_THAN.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 بزرگتر از %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.GREATER_THAN_OR_EQUALS.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 بزرگتر از یا مساوی %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN.Y'
,p_message_language=>'fa'
,p_message_text=>'%0 در این مجموعه هست %1'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST.Y.DAYS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 روز گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST.Y.HOURS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 ساعت گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST.Y.MINUTES'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 دقیقه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST.Y.MONTHS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 ماه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST.Y.WEEKS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 هفته گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST.Y.YEARS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 سال گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST_DAY'
,p_message_language=>'fa'
,p_message_text=>'%0 در روز گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST_HOUR'
,p_message_language=>'fa'
,p_message_text=>'%0 در ساعت گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST_MINUTE'
,p_message_language=>'fa'
,p_message_text=>'%0 در دقیقه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST_MONTH'
,p_message_language=>'fa'
,p_message_text=>'%0 در ماه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST_WEEK'
,p_message_language=>'fa'
,p_message_text=>'%0 در هفته گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_LAST_YEAR'
,p_message_language=>'fa'
,p_message_text=>'%0 در سال گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT.Y.DAYS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 روز بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT.Y.HOURS'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 ساعت بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.X.IN_THE_NEXT.Y.MINUTES'
,p_message_language=>'fa'
,p_message_text=>'%0 در %1 دقیقه بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LOW_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'پایین'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MAILADRESSES_COMMASEP'
,p_message_language=>'fa'
,p_message_text=>'چند آدرس را با کاما از هم جدا کنید'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MATCHES_REGULAR_EXPRESSION'
,p_message_language=>'fa'
,p_message_text=>'منطبق کردن با  regular expression'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MAX'
,p_message_language=>'fa'
,p_message_text=>'حداکثر'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MAX_OVERALL'
,p_message_language=>'fa'
,p_message_text=>'حداکثر کلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MEDIAN'
,p_message_language=>'fa'
,p_message_text=>'متوسط'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MEDIAN_OVERALL'
,p_message_language=>'fa'
,p_message_text=>'متوسط کلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MIN'
,p_message_language=>'fa'
,p_message_text=>'حداقل'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MINUTES'
,p_message_language=>'fa'
,p_message_text=>'دقیقه'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MINUTES_AGO'
,p_message_language=>'fa'
,p_message_text=>'دقیقه قبل'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MIN_OVERALL'
,p_message_language=>'fa'
,p_message_text=>'حداقل کلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MONTHS'
,p_message_language=>'fa'
,p_message_text=>'ماه'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.MORE_DATA_FOUND'
,p_message_language=>'fa'
,p_message_text=>'محتویات اطلاعات بیشتر از %0 ردیف که بیش از حداکثر مجاز تخمین زده شده می باشد. لطفا برای مشاهده جواب , داده های خود را فیلتر کنید.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NAME'
,p_message_language=>'fa'
,p_message_text=>'نام'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NAMED_REPORT'
,p_message_language=>'fa'
,p_message_text=>'نام گزارش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.DAY'
,p_message_language=>'fa'
,p_message_text=>'روز بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.HOUR'
,p_message_language=>'fa'
,p_message_text=>'ساعت بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.MINUTE'
,p_message_language=>'fa'
,p_message_text=>'دقیقه بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.MONTH'
,p_message_language=>'fa'
,p_message_text=>'ماه بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.WEEK'
,p_message_language=>'fa'
,p_message_text=>'هفته بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.X_DAYS'
,p_message_language=>'fa'
,p_message_text=>'%0 روز بعد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.X_HOURS'
,p_message_language=>'fa'
,p_message_text=>'%0 ساعت بعد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.X_MINUTES'
,p_message_language=>'fa'
,p_message_text=>'%0 دقیقه بعد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.X_MONTHS'
,p_message_language=>'fa'
,p_message_text=>'%0 ماه بعد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.X_WEEKS'
,p_message_language=>'fa'
,p_message_text=>'%0 هفته بعد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.X_YEARS'
,p_message_language=>'fa'
,p_message_text=>'%0 سال بعد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NEXT.YEAR'
,p_message_language=>'fa'
,p_message_text=>'سال بعدی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NOT_BETWEEN'
,p_message_language=>'fa'
,p_message_text=>'مابین نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NOT_EQUALS'
,p_message_language=>'fa'
,p_message_text=>'مساوی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NOT_EXIST'
,p_message_language=>'fa'
,p_message_text=>'ناحیه(Region) با  ID %0 در این Interactive Grid region وجود ندارد یا اینکه در این اپلیکیشن  %1 موجود نیست.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NOT_IN'
,p_message_language=>'fa'
,p_message_text=>'در مجموعه نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NOT_IN_THE_LAST'
,p_message_language=>'fa'
,p_message_text=>'در آخر نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NOT_IN_THE_NEXT'
,p_message_language=>'fa'
,p_message_text=>'در بعدی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NO_DATA_FOUND'
,p_message_language=>'fa'
,p_message_text=>'هیج اطلاعاتی یافت نشد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NULLS'
,p_message_language=>'fa'
,p_message_text=>'تهی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.NUMBER'
,p_message_language=>'fa'
,p_message_text=>'عددی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.OFF'
,p_message_language=>'fa'
,p_message_text=>'خاموش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ON'
,p_message_language=>'fa'
,p_message_text=>'روشن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ONE_MINUTE_AGO'
,p_message_language=>'fa'
,p_message_text=>'1 دقیقه قبل'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.OPEN_COLORPICKER'
,p_message_language=>'fa'
,p_message_text=>'باز کردن گسترش رنگ: %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.OPEN_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'بازکردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.OPERATOR'
,p_message_language=>'fa'
,p_message_text=>'عمگر'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ORIENTATION'
,p_message_language=>'fa'
,p_message_text=>'جهت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.PIE'
,p_message_language=>'fa'
,p_message_text=>'پای (Area)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.PIVOT'
,p_message_language=>'fa'
,p_message_text=>'محور-Pivot'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.PIVOT_VIEW'
,p_message_language=>'fa'
,p_message_text=>'نمایش محور-Pivot'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.PLACEHOLDER_INVALUES'
,p_message_language=>'fa'
,p_message_text=>'جداسازی مقادیر با "%0"'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.POLAR'
,p_message_language=>'fa'
,p_message_text=>'قطبی(متقارن)(Polar)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.POSITION_CENTER'
,p_message_language=>'fa'
,p_message_text=>'مرکز'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.POSITION_END'
,p_message_language=>'fa'
,p_message_text=>'پایان'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.POSITION_START'
,p_message_language=>'fa'
,p_message_text=>'شروع'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.PRIMARY'
,p_message_language=>'fa'
,p_message_text=>'اصلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.PRIMARY_DEFAULT'
,p_message_language=>'fa'
,p_message_text=>'پیش فرض اصلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.PRIMARY_REPORT'
,p_message_language=>'fa'
,p_message_text=>'گزارش اصلی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.RADAR'
,p_message_language=>'fa'
,p_message_text=>'رادار (Radar)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.RANGE'
,p_message_language=>'fa'
,p_message_text=>'محدوده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REFRESH'
,p_message_language=>'fa'
,p_message_text=>'تازه سازی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REFRESH_ROW'
,p_message_language=>'fa'
,p_message_text=>'تازه سازی ردیف'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REFRESH_ROWS'
,p_message_language=>'fa'
,p_message_text=>'تازه سازی ردیف ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REMOVE_CONTROL'
,p_message_language=>'fa'
,p_message_text=>'برداشته شد %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT'
,p_message_language=>'fa'
,p_message_text=>'گزارش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT.DELETED'
,p_message_language=>'fa'
,p_message_text=>'گزارش حذف شد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT.SAVED.ALTERNATIVE'
,p_message_language=>'fa'
,p_message_text=>'گزارش جایگزین برای همه کاربران ذخیره شد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT.SAVED.DEFAULT'
,p_message_language=>'fa'
,p_message_text=>'گزارش پیش فرض برای همه کاربران ذخیره شد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT.SAVED.PRIVATE'
,p_message_language=>'fa'
,p_message_text=>'گزارش اصلی ذخیره شد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT.SAVED.PUBLIC'
,p_message_language=>'fa'
,p_message_text=>'گزارش عمومی برای همه کاربران ذخیره شد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT_DATA_AS_OF.X.MINUTES_AGO'
,p_message_language=>'fa'
,p_message_text=>'گزارش داده از %0 دقیقه قبل'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT_DATA_AS_OF_ONE_MINUTE_AGO'
,p_message_language=>'fa'
,p_message_text=>'گزارش داده از 1 دقیقه قبل'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT_EDIT'
,p_message_language=>'fa'
,p_message_text=>'گزارش - ویرایش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT_SAVE_AS'
,p_message_language=>'fa'
,p_message_text=>'گزارش - ذخیره بعنوان'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT_SETTINGS'
,p_message_language=>'fa'
,p_message_text=>'تنظیمات گزارش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT_STATIC_ID_DOES_NOT_EXIST'
,p_message_language=>'fa'
,p_message_text=>'وجود ندارد Static ID %0  ذخیره شده با Interactive Grid'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REPORT_VIEW'
,p_message_language=>'fa'
,p_message_text=>'مشاهده گزارش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.RESET'
,p_message_language=>'fa'
,p_message_text=>'تنظیم مجدد'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.REVERT_CHANGES'
,p_message_language=>'fa'
,p_message_text=>'برگرداندن تغییرات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.CONTROL_BREAK_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای کنترل جداکننده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.DOWNLOAD'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p> با استفاده از این پنجره دانلود تمام ردیف های اطلاعاتی فعلی در یک فایل خارجی امکانپذیر می باشد. فایل تنها شامل ستون های در حال حاضر نمایش داده شده، با استفاده از هر فیلتر و مرتب سازی اعمال شده بر روی داده ها می باشد.</p>',
'<p>فرمت فایل را انتخاب و روی دانلود کلیک کنید. <br>',
'توجه: CSV قالب بندی متن مانند کنترل جداکننده و تجمیع را شامل نمی باشد.</p>',
'<p>برای ایمیل کردن فایل، انتخاب ارسال بعنوان ایمیل و وارد کردن جزئیات ایمیل (گیرنده، موضوع و پیام).</p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.DOWNLOAD_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای دانلود'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.FILTER'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از این پنجره، تعریف پیکربندی فیلتر بر روی داده ها برای نمایش آنها، امکان پذیر می باشد</p>',
'<p><strong>لیست فیلتر</strong></p>',
'<p>لیست فیلتر ، فیلترهای تعریف شده را نمایش می دهد. غیر فعال کردن یک فیلتر موجود توسط عدم انتخاب آن امکانپذیر می باشد. <br>',
'<p>با کلیک بر روی اضافه کردن ( &plus; ) یک فیلتر جدید ایجاد می کنید و یا حذف ( &minus; ) می تواند فیلتر های موجود را پاک کرد</p>',
'<p><strong>تنظیمات فیلتر </strong> <br>',
'با استفاده از فرم تعریف فیلتر. <br>',
'انتخاب نوع فیلتر مناسب: <br>',
'&nbsp;&nbsp;&nbsp; ردیف - فیلتر برای یک دوره در هر ستون قابل پالایش <br>',
'&nbsp;&nbsp;&nbsp; ستون - فیلتر کردن یک ستون خاص با یک عملگر و مقدار مشخص </p>',
'<p><em>توجه: در هنگام مشاهده interactive grid، شما می توانید فیلترهای ردیف با تایپ کردن به طور مستقیم در قسمت جستجو را تعریف کنیم. با کلیک کردن ستون ها و انتخاب آنها جستجو کنید و یا برای محدود کردن جستجو بوسیله یک ستون خاص استفاده ببرید. همچنین، باز '
||'کردن یک منوعنوان بر روی ستون ها و انتخاب یکی از مقادیر می توانید بر روی ستون عمل فیلتر را انجام دهید.</em></p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.FILTER_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای فیلتر کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.FLASHBACK'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از این پنجره، نمایش داده ها در یک نقطه زمانی قبل، امکان پذیر می باشد</p>',
'<p>مقدار دقیقه را که از اجرای کوئری شما گذشته را وارد کنید.</p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.FLASHBACK_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای برگشت به عقب(Flashback)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.GROUP_BY_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای گروه بندی کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.HIGHLIGHT'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از این پنجره، برجسته ردیف یا ستون از داده ها بر اساس شرایط وارد شده، امکان پذیر می باشد</p>',
'<p><strong>لیست برجسته کردن</strong></p>',
'<p>لیست برجسته ، برجسته های تعریف شده را نمایش می دهد. غیر فعال کردن یک برجسته موجود توسط عدم انتخاب آن امکانپذیر می باشد. <br>',
'<p>با کلیک بر روی اضافه کردن ( &plus; ) یک برجسته جدید ایجاد می کنید و یا حذف ( &minus; ) می تواند برجسته های موجود را پاک کرد</p>',
'<p><strong>تنظیمات برجسته </strong> <br>',
'با استفاده از فرم تعریف برجسته. <br>',
'نام، ردیف یا ستون را انتخاب و وارد کنید، و کد رنگ HTML برای پس زمینه و متن را انتخاب کنید. <br>',
'انتخاب مناسب <strong>نوع ساختار</strong>برجسته کردن داده های خاص: <br>',
'&nbsp;&nbsp;&nbsp; ردیف - برجسته کردن یک دوره در هر ستون <br>',
'&nbsp;&nbsp;&nbsp; ستون - برجسته کردن یک ستون خاص با یک عملگر و مقدار مشخص </p>',
'',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.HIGHLIGHT_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای برجسته کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.REPORT'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از این پنجره، برای ذخیره تغییراتی که از ایجاد کردن طرح جاری interactive grid  و پیکربندی آن بوجود آوردید مورد استفاده قرار می گیرد<br>',
'توسعه دهندگان نرم افزار می توانند چند طرح بندی گزارش های متناوب را تعریف کننند. که در آن مجاز است، شما و دیگر کاربران نهایی  (End Users) بتوانید یک گزارش به عنوان عمومی، که باعث می شود این گزارش در دسترس همه کاربران دیگر در شبکه قرار گیرد را تعریف کن'
||'ید. شما همچنین می توانید یک گزارش به عنوان یک گزارش شخصی که فقط برای شما قابل مشاهده است را ایجاد کنید.</p>',
'<p> ازانواع موجود در فرم یکی را انتخاب و یک نام برای این گزارش ذخیره شده وارد کنید.</p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.REPORT_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای گزارش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.SORT'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از این پنجره، نمایش ترتیب مشاهده را تعریف کنید</p>',
'<p><strong>لیست مرتب سازی</strong></p>',
'<p>پنجره مرتب سازی یک لیست از قوانین مرتب سازی پیکربندی شده را نمایش می هد. <br>',
'<p>با کلیک بر روی اضافه کردن ( &plus; ) یک مرتب سازی جدید ایجاد می کنید و یا حذف ( &minus; ) می تواند مرتب سازی های موجود را پاک کرد</p>',
'<p><strong>تنظیمات مرتب سازی </strong> <br>',
'انتخاب یک کنترل جداکننده مرتب سازی ، جهت مرتب کردن ، و نحوه مرتب سازی ستون های تهی (ستون ها بدون مقدار).</p>',
'<p><em>توجه: اطلاعات را می توان با ستونهایی که نمایش داده نمی شود طبقه بندی کرد. با این حال، تمام ستون ممکن است قابل مرتب شدن نباشد. </em><br>',
'',
'<em> ستون های نمایش داده شده می تواند با فشار دادن (صعودی) یا پایین (نزولی) فلش در پایان عنوان ستون ها طبقه بندی شوند. برای اضافه کردن یک ستون پس از مرتب کردن بر اساس سنون های موجود، کلید Shift را نگه دارید و بر روی فلش بالا یا پایین کلیک کنید.</em><'
||'/p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.SORT_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای مرتب سازی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.SUBSCRIPTION_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای اشتراک'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HIDE'
,p_message_language=>'fa'
,p_message_text=>'مخفی کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HIGHLIGHT'
,p_message_language=>'fa'
,p_message_text=>'برجسته کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HIGH_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'بالا'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HORIZONTAL'
,p_message_language=>'fa'
,p_message_text=>'افقی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HOURS'
,p_message_language=>'fa'
,p_message_text=>'ساعت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ICON'
,p_message_language=>'fa'
,p_message_text=>'آیکن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ICON_VIEW'
,p_message_language=>'fa'
,p_message_text=>'مشاهده براساس آیکن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.IN'
,p_message_language=>'fa'
,p_message_text=>'در مجموعه است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INACTIVE_SETTING'
,p_message_language=>'fa'
,p_message_text=>'غیرفعال کردن تنظیمات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INACTIVE_SETTINGS'
,p_message_language=>'fa'
,p_message_text=>'غیرفعال کردن تنظیمات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INTERNAL_ERROR'
,p_message_language=>'fa'
,p_message_text=>'در هنگام پردازش درخواست Interactive Grid ,یک خطای داخلی رخ داده است.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INVALID_DATE_FORMAT'
,p_message_language=>'fa'
,p_message_text=>'نامعتبر بودن فرمت تاریخ'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INVALID_SETTING'
,p_message_language=>'fa'
,p_message_text=>'نامعتبر بودن تنظیمات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INVALID_SETTINGS'
,p_message_language=>'fa'
,p_message_text=>'نامعتبر بودن تنظیمات'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INVALID_SORT_BY'
,p_message_language=>'fa'
,p_message_text=>'مرتب سازی براساس %0 انجام شده است, اما هیچ ستونی به عنوان %0 انتخاب نشده است.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INVALID_VALUE'
,p_message_language=>'fa'
,p_message_text=>'نامعتبر بودن مقدار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.INVISIBLE'
,p_message_language=>'fa'
,p_message_text=>'نمایش داده نشده'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.IN_THE_LAST'
,p_message_language=>'fa'
,p_message_text=>'در آخر است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.IN_THE_NEXT'
,p_message_language=>'fa'
,p_message_text=>'در بعدی است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.IS_NOT_NULL'
,p_message_language=>'fa'
,p_message_text=>'خالی نیست'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.IS_NULL'
,p_message_language=>'fa'
,p_message_text=>'خالی است'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LABEL'
,p_message_language=>'fa'
,p_message_text=>'برچسب'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LABEL_COLUMN'
,p_message_language=>'fa'
,p_message_text=>'برچسب'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST'
,p_message_language=>'fa'
,p_message_text=>'گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.DAY'
,p_message_language=>'fa'
,p_message_text=>'روز گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.HOUR'
,p_message_language=>'fa'
,p_message_text=>'ساعت گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.MINUTE'
,p_message_language=>'fa'
,p_message_text=>'دقیقه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.MONTH'
,p_message_language=>'fa'
,p_message_text=>'ماه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.WEEK'
,p_message_language=>'fa'
,p_message_text=>'هفته گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.X_DAYS'
,p_message_language=>'fa'
,p_message_text=>'%0 روز گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.X_HOURS'
,p_message_language=>'fa'
,p_message_text=>'%0 ساعت گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.X_MINUTES'
,p_message_language=>'fa'
,p_message_text=>'%0 دقیقه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.X_MONTHS'
,p_message_language=>'fa'
,p_message_text=>'%0 ماه گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.X_WEEKS'
,p_message_language=>'fa'
,p_message_text=>'%0 هفته گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.X_YEARS'
,p_message_language=>'fa'
,p_message_text=>'%0 سال گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAST.YEAR'
,p_message_language=>'fa'
,p_message_text=>'سال گذشته'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAYOUT_ALIGN'
,p_message_language=>'fa'
,p_message_text=>'ترازبندی سلول'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LAYOUT_USEGROUPFOR'
,p_message_language=>'fa'
,p_message_text=>'استفاده گروه بندی برای'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LESS_THAN'
,p_message_language=>'fa'
,p_message_text=>'کمتر از'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LESS_THAN_OR_EQUALS'
,p_message_language=>'fa'
,p_message_text=>'کمتر یا مساوی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LINE'
,p_message_language=>'fa'
,p_message_text=>'خطی (Line)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LINE_WITH_AREA'
,p_message_language=>'fa'
,p_message_text=>'خطی با ناحیه ای (Line with Area)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.LISTAGG'
,p_message_language=>'fa'
,p_message_text=>'Listagg'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EMAIL_SUBJECT'
,p_message_language=>'fa'
,p_message_text=>'موضوع'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EMAIL_TO'
,p_message_language=>'fa'
,p_message_text=>'گیرنده (به)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.ENABLED'
,p_message_language=>'fa'
,p_message_text=>'فعال'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EQUALS'
,p_message_language=>'fa'
,p_message_text=>'مساوی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EXAMPLE'
,p_message_language=>'fa'
,p_message_text=>'مثال'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.EXPRESSION'
,p_message_language=>'fa'
,p_message_text=>'عبارت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FD_TYPE'
,p_message_language=>'fa'
,p_message_text=>'نوع'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FILTER'
,p_message_language=>'fa'
,p_message_text=>'فیلتر کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FILTERS'
,p_message_language=>'fa'
,p_message_text=>'فیلترها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FILTER_WITH_DOTS'
,p_message_language=>'fa'
,p_message_text=>'فیلتر...'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FIRST'
,p_message_language=>'fa'
,p_message_text=>'اول'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FLASHBACK'
,p_message_language=>'fa'
,p_message_text=>'(فلش بک(بازگشت به عقب'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FORMAT'
,p_message_language=>'fa'
,p_message_text=>'فرمت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FORMATMASK'
,p_message_language=>'fa'
,p_message_text=>'شکل فرمت'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FORMAT_CSV'
,p_message_language=>'fa'
,p_message_text=>'CSV'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FORMAT_HTML'
,p_message_language=>'fa'
,p_message_text=>'HTML'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FREEZE'
,p_message_language=>'fa'
,p_message_text=>'فریز(ثابت کردن)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FUNCTIONS_AND_OPERATORS'
,p_message_language=>'fa'
,p_message_text=>'توابع و عملگرها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.FUNNEL'
,p_message_language=>'fa'
,p_message_text=>'قیفی (Funnel)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.GO'
,p_message_language=>'fa'
,p_message_text=>'برو'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.GREATER_THAN'
,p_message_language=>'fa'
,p_message_text=>'بزرگتر از'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.GREATER_THAN_OR_EQUALS'
,p_message_language=>'fa'
,p_message_text=>'بزرگتر یا مساوی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.GRID'
,p_message_language=>'fa'
,p_message_text=>'Grid'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.GRID_VIEW'
,p_message_language=>'fa'
,p_message_text=>'نمایش Grid'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.GROUP'
,p_message_language=>'fa'
,p_message_text=>'گروه بندی کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.GROUP_BY'
,p_message_language=>'fa'
,p_message_text=>'گروه بندی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.GROUP_BY_VIEW'
,p_message_language=>'fa'
,p_message_text=>'مشاهده براساس گروه بندی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HD_TYPE'
,p_message_language=>'fa'
,p_message_text=>'نوع شرایط'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HEADING'
,p_message_language=>'fa'
,p_message_text=>'عنوان'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HEADING_ALIGN'
,p_message_language=>'fa'
,p_message_text=>'ترازبندی عنوان'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP'
,p_message_language=>'fa'
,p_message_text=>'راهنما'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.ACTIONS.EDITING'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>شما می توانید بصورت مستقیم می توانید insert, update و delete بر روی داده ها را در interactive grid انجام دهید</p>',
'<p>برای ایجاد رکورد جدید باید بر روی دکمه اضافه کردن ردیف کلیک کنید</p>',
'<p>برای ویرایش هر سلول مورد نظر شما باید بر روی آن عمل دابل کلیک را انجام دهید. برای ویرایش بیشتر بهتر است که بر روی دکمه ویرایش کلیک کنید تا حالت ویرایش برای همه سلول ها فعال شود. حال می توانید با عمل کلیک بر روی هر سلول بتوانید آنرا ویرایش کنید</p>',
'<p>برای عملیاتی مانند اضافه کردن و ایجاد رکورد تکرای می توانید از منو تغییرات استفاده نمایید. برای فعال کردن منو کافیست که آن رکورد یا چندین رکورد مورد نظر، توسط چک باکس ردیف ها فعال شده باشد</p>',
'',
'<p>برای ایجاد رکورد تکراری می توانید با کلیک کردن بر روی منو تغییرات یا منو انتخاب عملیات استفاده نمایید. حذف رکورد می توانید با کلیک کردن بر روی منو تغییرات یا منو انتخاب عملیات انجام پذیرد. </p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.ACTIONS.EDITING_HEADING'
,p_message_language=>'fa'
,p_message_text=>'قابلیت های ویرایش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.ACTIONS.INTRO'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>یک interactive grid یک مجموعه ای از داده ها را که امکان جستجو و سفارشی سازی داشته باشد را ارائه می دهد. شما می توانید چندین عملگر را برای محدود کردن ردیف های اطلاعاتی که مد نظر شما باشد را انجام دهید، و برای نمایش اطلاعات به هر نحویی که خواسته باش'
||'ید تغییرات را اعمال کنید</p>   ',
'<p>می توانید عمل جستجو را بر روی فیلدها برای فیلتر کردن نمایش اطلاعات انجام دهید. با کلیک بر روی دکمه عملیات به تعداد زیادی انتخاب برای تغییرات بر روی طرح گزارش دسترسی خواهید داشت، یا اینکه می توانید از منو عنوان بر روی هر ستون گزارش استفاده نمایید.<'
||'/p>',
'<p>می توانید از طریق تنظیمات گزارش، گزارش خود را پس از سفارشی کردن ذخیره نمایید. همچنین امکان دانلود آن بصورت یک فایل و یا اینکه بخواهید آنرا  به دیگران ایمیل کنید امکان پذیر می باشد</p>',
'<p>برای اطلاعات بیشتر می توانید از راهنمای کاریران Oracle Application Express استفاده نمایید</p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.ACTIONS.INTRO_HEADING'
,p_message_language=>'fa'
,p_message_text=>'بررسی اجمالی'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.ACTIONS.REPORTING'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>شما می توانید نمایش اطلاعات را در interactive grid به روش های مختلفی با استفاده از قابلیتهای موجود، سفارشی سازی کنید.</p>',
'<p>برای اینکه بخواهید کدام ستون ها نمایش داده شود و یا اینکه نمایش داده نشود و ترتیب نمایش آنها و یا حتی ثابت کردن ستون ها (Freeze) می توانید از طریق عنوان ستون ها یا دکمه عملیات استفاده نمایید. همچنین شما می توانید عملیات مرتب سازی و فیلتر کردن داده'
||' هایی که می خواهید نمایش داده شود را انجام دهید</p>',
'<p> با استفاده از دکمه ویرایش (در مجاورت جستجو ستون) در صورتیکه توسط توسعه دهنده برای شما تعریف شده باشد امکان دسترسی به دیگر عملیات نمایش داده ها را خواهید داشت. همچنین شما می توانید از نمودارهای موجود و یا اینکه امکان ایجاد نمودار استفاده نمایید.</'
||'p>',
'<p><em>توجه: با کلیک بر روی <strong>دکمه راهنما</strong> در صفحه interactive grid پس ازانتخاب هر کدام از توابع، اطلاعات بیشتری را بدست خواهید آورد</em></p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.ACTIONS.REPORTING_HEADING'
,p_message_language=>'fa'
,p_message_text=>'قابیلت های گزارش'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.ACTIONS_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای Interactive Grid'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.AGGREGATE'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>استفاده از پنجره تجمیع کردن ستون ها. نمایش تجمیعی مقادیر در پایین هر کدام از اطلاعات یا در پایین هر جداکننده در صورت تعریف کنترل جداکننده ها امکان پذیر خواهد بود</p>',
'<p><strong>لیست تجمیع</strong> </p>',
'<p>لیست تجمیع با تعریف تجمیع ها نمایش داده می شود. تجمیع های موجود با برداشتن انتخاب آنها غیر فعال می شود</p>',
'<p>با کلیک بر روی اضافه ( &plus; ) یک تجمیع جدید ایجاد می کنید و یا حذف ( &minus; ) می تواند تجمیع های موجود را پاک کرد</p>',
'<p><strong>تنظیمات تجمیع</strong> </p>',
'<br> با استفاده از فرم در سمت چپ برای تعریف تجمیع</br>',
'<br>انتخاب نام ستون و نوع تجمیع</br>',
'<br>اختیاری، وارد کردن راهنمای ابزار برای تجمیع</br>',
'<p>اگر شما یک جدا کننده را تعریف کرده باشید، <strong>نمایش کل مقادیر</strong> میانکین کل ، جمع کل و یا مقادیر شبیه آن در پایین صفحه نمایش داده می شود.</p>',
'<p><em>توجه: برای دسترسی به پنچره تجمیع در منو عملیات یا بوسیله کلیک کردن بر روی هر کدام از عنوان های ستون و جمع ( &sum; ) می توان استفاده کرد.</p></em>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.AGGREGATE_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای تجمیع کردن'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.CHART_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای نمودار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.COLUMNS'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از این پنجره انتخاب می کنید که نمایش ستون ها به چه ترتیبی باشد</p>',
'<p>مخفی کردن یک ستون با عدم انتخاب آن امکانپذیر می باشد<br>',
'تغییر مجدد ترتیب ستون با کلیک کردن حرکت به بالا ( &uarr; ) یا انتقال به پایین ( &darr; ). <br>',
'با استفاده از منوی کشویی نمایش لیست تمام ستون ها، ستون نمایش داده شده ، یا ستون نمایش داده نشده قابل انتخاب می باشد</p>',
'<p>در صورت تمایل، با استفاده از فرم برای مشخص کردن حداقل عرض یک ستون در پیکسل امکان پذیر می باشد</p>',
'<p><em>توجه: شما همچنین می توانید ستون نمایش داده شده توسط کلیک کردن بر روی دسته کشیدن (در آغاز سر ستون را) و کشیدن ستون سمت چپ یا راست را دوباره مرتب کنید. شما همچنین می توانید عرض ستون از ستون نمایش داده با انتخاب جداکننده ستون، میان عناوین، و حرکت'
||' آن به سمت چپ یا راست تغییر دهید</em></p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.COLUMNS_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای ستون ها'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.COMPUTE'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از این پنجره به تعریف ستون های اضافی بر اساس محاسبات ریاضی و کاربردی در برابر ستون های موجود امکان پذیر می باشد</p>',
'<p><strong>لیست محاسبات</strong></p>',
'<p>لیست محاسبات ، محاسبات تعریف شده را نمایش می دهد. غیر فعال کردن یک محاسبه موجود توسط عدم انتخاب آن امکانپذیر می باشد. <br>',
'<p>با کلیک بر روی اضافه کردن ( &plus; ) یک محاسبه جدید ایجاد می کنید و یا حذف ( &minus; ) می تواند محاسبه های موجود را پاک کرد</p>',
'<p><strong>تنظیمات محاسبه</strong> <br>',
'با استفاده از فرم تعریف محاسبات. <br>',
'جزئیات ستون مانند عنوان، برچسب را وارد کنید و تنظیمات تراز  را انتخاب نمایید. <br>',
'استفاده از عبارتهای متن و وارد کردن ستون (ها) و توابع مرتبط برای محاسبه امکانپذیر می باشد. <br>',
'نوع داده مناسب را انتخاب کنید، و یک فرمت قالب، برای ستون جدید می توانید تعریف کنید(اختیاری)',
'</p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.COMPUTE_TITLE'
,p_message_language=>'fa'
,p_message_text=>'راهنمای محاسبه'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.IG.HELP.CONTROL_BREAK'
,p_message_language=>'fa'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>با استفاده از این پنجره، تعریف یک جدا کننده بر روی یک یا چندین ستون امکان پذیر می باشد</p>',
'<p><strong>لیست جداکننده</strong></p>',
'<p>لیست جداکننده ، جداکننده های تعریف شده را نمایش می دهد. غیر فعال کردن یک جداکننده موجود توسط عدم انتخاب آن امکانپذیر می باشد. <br>',
'<p>با کلیک بر روی اضافه کردن ( &plus; ) یک جداکننده جدید ایجاد می کنید و یا حذف ( &minus; ) می تواند جداکننده های موجود را پاک کرد</p>',
'<p><strong>تنظیمات جداکننده</strong> <br>',
'با استفاده از فرم تعریف جداکننده. <br>',
'انتخاب یک کنترل جداکننده ستون، جهت مرتب کردن ، و نحوه مرتب سازی ستون های تهی (ستون ها بدون مقدار).</p>',
'<p><em>توجه: در هنگام مشاهده interactive grid، شما می توانید یک کنترل جداکننده با کلیک روی یک عنوان ستون و انتخاب آیکون کنترل جداکننده تعریف کنید.</em></p>',
''))
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'LAYOUT.CHART'
,p_message_language=>'fa'
,p_message_text=>'نمودار'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'LAYOUT.T_#EXPAND_COLLAPSE_NAV_LABEL#'
,p_message_language=>'fa'
,p_message_text=>'برچسب برای باز کردن/ بستن ستون جهت یابی  (Navigation)'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'LAYOUT.T_#EXPAND_COLLAPSE_SIDE_COL_LABEL#'
,p_message_language=>'fa'
,p_message_text=>'برچسب برای باز کردن/ بستن ستون مجاور'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'NAME'
,p_message_language=>'fa'
,p_message_text=>'PERSIAN'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEX.ACTIONS.TOGGLE'
,p_message_language=>'fa'
,p_message_text=>'تغییر وضعیت %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEXIR_REGION_STATIC_ID_DOES_NOT_EXIST'
,p_message_language=>'fa'
,p_message_text=>'وجود ندارد Region Static ID %0'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'APEXIR_REMOVE_REPORT'
,p_message_language=>'fa'
,p_message_text=>'حذف گزارش'
,p_is_js_message=>true
);
 
  
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'CHART_SERIES_ERROR'
,p_message_language=>'fa'
,p_message_text=>'خطا سلسه نمودار %0 برای %1.'
,p_is_js_message=>true
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'REGION_NAME.NATIVE_JET_CHART'
,p_message_language=>'fa'
,p_message_text=>'نمودار'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'SHOW_ALL'
,p_message_language=>'fa'
,p_message_text=>'نمایش همه'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'UPGRADE_CANDLESTICK_CHART'
,p_message_language=>'fa'
,p_message_text=>'پس از ارتقاء، از نگاشته شدن سری های ویژگی برچسب ستون به یک تاریخ / برچسب زمان ستون اطمینان حاصل کنید'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_CREATE_MODEL_APP.CREATE_IG'
,p_message_language=>'fa'
,p_message_text=>'امکان ایجاد صفحه شبکه تعاملی (IR) وجود ندارد: %0'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_CUSTOMIZE.T_MESSAGE3'
,p_message_text=>'شما می توانید ظاهر این نرم افزار را با تغییر سبک تم , شخصی سازی کنید. لطفا یک سبک تم را از لیست زیر انتخاب کنید و بر روی دکمه اعمال تغییرات کلیک کنید'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_CUSTOMIZE.T_REGION_DISP'
,p_message_language=>'fa'
,p_message_text=>'نمایش ناحیه (Region)'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_CUSTOMIZE.T_REMOVE_STYLE'
,p_message_language=>'fa'
,p_message_text=>'استفاده از سبک پیش فرض اپلیکیشن'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_CUSTOMIZE.T_THEME_STYLE'
,p_message_language=>'fa'
,p_message_text=>'ظاهر'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_DATA_EXPORT.AGG_COLUMN_IDX_NOT_EXIST'
,p_message_language=>'fa'
,p_message_text=>'شاخص ستون اشاره شده در تجمیع %0 وجود ندارد.'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_DATA_EXPORT.COLUMN_GROUP_IDX_NOT_EXIST'
,p_message_language=>'fa'
,p_message_text=>'خروج.'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_DATA_EXPORT.HIGHLIGHT_COLUMN_IDX_NOT_EXIST'
,p_message_language=>'fa'
,p_message_text=>'شاخص ستون اشاره شده در برجسته %0 وجود ندارد.'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_DATA_EXPORT.PARENT_GROUP_IDX_NOT_EXIST'
,p_message_language=>'fa'
,p_message_text=>'خروج.'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_WEB_SERVICES.AUTHENTICATION_FAILED'
,p_message_language=>'fa'
,p_message_text=>'احراز هویت انجام نشد'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_WEB_SERVICES.NO_VALID_OAUTH_TOKEN'
,p_message_language=>'fa'
,p_message_text=>'توکن دسترسی OAuth در دسترس نمی باشد یا اینکه منقضی شده است.'
);
 
 
 
wwv_flow_api.create_message(
 p_id => null
,p_flow_id => v_app_id
,p_name=>'WWV_FLOW_WEB_SERVICES.UNSUPPORTED_OAUTH_TOKEN'
,p_message_language=>'fa'
,p_message_text=>'سرور با نوع توکن OAuth پشتیبانی نشده پاسخ داد.'
);
 
END;
/

