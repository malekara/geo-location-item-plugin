prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>8334703299300574
,p_default_application_id=>12004
,p_default_id_offset=>91435856050721469
,p_default_owner=>'EN'
);
end;
/
 
prompt APPLICATION 12004 - EDMS
--
-- Application Export:
--   Application:     12004
--   Name:            EDMS
--   Date and Time:   12:35 Wednesday April 14, 2021
--   Exported By:     ADMIN
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 188137292473267424
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     241697313674546
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/com_malekara_item_type_of_coordinate_sys
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(188137292473267424)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'COM.MALEKARA.ITEM_TYPE_OF_COORDINATE_SYS'
,p_display_name=>'Types of Coordinate Systems'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_render_param,',
'    p_result in out nocopy apex_plugin.t_item_render_result )',
'is',
'  -- internal plugin variables',
'  c_escape_chars         constant varchar2(255)   := chr(10)||chr(11)||chr(13);',
'  c_plugin_type          constant varchar2(255)   := ''SIMPLE_CHECKBOX'';',
'  c_element_id           constant varchar2(255)   := p_item.name;',
'  l_item_name            varchar2(30);',
'  l_init_code            varchar2(32767);',
'  l_html_string          varchar2(2000);',
'  --',
'  -- custom plugin attributes',
'  c_checked_value        constant varchar2(255)   := nvl(p_item.attribute_01, 1);',
'  c_unchecked_value      constant varchar2(255)   := nvl(p_item.attribute_02, 0);',
'  c_checkbox_label       constant varchar2(4000)  := p_item.attribute_03;',
'  --',
'  -- other vars',
'  l_checkbox_postfix varchar2(8);',
'  ',
'  c_escaped_value        varchar2(4000) := case',
'                                             when p_param.value in (c_checked_value, c_unchecked_value) then apex_escape.html(p_param.value)',
'                                             else c_unchecked_value',
'                                           end; ',
'begin',
'  -- printer friendly display',
'  if p_param.is_printer_friendly then',
'    apex_plugin_util.print_display_only(',
'      p_item_name        => p_item.name,',
'      p_display_value    => p_param.value,',
'      p_show_line_breaks => false,',
'      p_escape           => true,',
'      p_attributes       => p_item.element_attributes',
'    );',
'',
'  -- read only display',
'  elsif p_param.is_readonly then',
'    apex_plugin_util.print_hidden_if_readonly(',
'      p_item_name           => p_item.name,',
'      p_value               => p_param.value,',
'      p_is_readonly         => p_param.is_readonly,',
'      p_is_printer_friendly => p_param.is_printer_friendly,',
'      p_id_postfix          => ''HIDDEN''',
'    );',
'',
'  -- normal display',
'  else',
'    l_item_name     := apex_plugin.get_input_name_for_page_item(false);',
'    ',
'      ',
'',
'',
'',
'    -- build input html string',
'    ',
'    l_html_string := ''<input type="text" '';',
'    l_html_string := l_html_string || ''name="'' || l_item_name || ''" '';',
'    l_html_string := l_html_string || ''id="'' || c_element_id || ''" '';',
'    l_html_string := l_html_string || ''value="'' || c_escaped_value || ''" '';',
'    l_html_string := l_html_string || ''class="'' || p_item.element_css_classes || '' apex-item-text text_field " '';',
'',
'  ',
'    l_html_string := l_html_string || '' />'';',
'    ',
'    --',
'    sys.htp.prn(l_html_string);',
'    --',
'  end if;',
'  ',
' /* apex_javascript.add_library (',
'    p_name      => ''simple-checkbox'',',
'    p_directory => p_plugin.file_prefix,',
'    p_version   => null',
'  );',
'*/',
' /* apex_javascript.add_onload_code (',
'    p_code => ''ca_trevis_apex_simple_checkbox(''||',
'              apex_javascript.add_value(p_item.name)||',
'              ''{''||',
'              apex_javascript.add_attribute(''unchecked'', c_unchecked_value, false)||',
'              apex_javascript.add_attribute(''checked'',   c_checked_value, false, false)||',
'              ''});''',
'  );*/',
'  --',
'  /*sys.htp.prn(',
'    ''<div class="checkbox_group apex-item-checkbox simple-checkbox">''',
'  );',
'',
'  sys.htp.prn (',
'    ''<input type="checkbox" id="''||p_item.name||l_checkbox_postfix||''" ''|| ''name="'' || p_item.name || ''"'' ||',
'    ''value="''||c_checked_value||''" data-checked-value="'' || c_checked_value || ''" data-unchecked-value="'' || c_unchecked_value || ''" ''|| case when c_escaped_value = c_checked_value then ''checked="checked" '' end ||',
'    case when p_param.is_readonly then ''disabled="disabled"'' else '''' end || ',
'    coalesce(p_item.element_attributes, '''') || '' />''',
'  );',
'',
'  sys.htp.prn(',
'    ''<label for="'' || p_item.name || l_checkbox_postfix || ''">'' || c_checkbox_label || ''</label>''',
'  );',
'',
'  sys.htp.prn(',
'    ''</div>''',
'  );*/',
'  p_result.is_navigable := true;',
'end render;',
'',
'procedure validate (',
'  p_item   in            apex_plugin.t_item,',
'  p_plugin in            apex_plugin.t_plugin,',
'  p_param  in            apex_plugin.t_item_validation_param,',
'  p_result in out nocopy apex_plugin.t_item_validation_result )',
'as',
'  l_checked_value   varchar2(255) := nvl(p_item.attribute_01, ''1'');',
'  l_unchecked_value varchar2(255) := nvl(p_item.attribute_02, ''0'');',
'begin',
'  if not (p_param.value in (l_checked_value, l_unchecked_value)',
'          or (p_param.value is null and l_unchecked_value is null)',
'         )',
'  then',
'      p_result.message := ''Checkbox contains invalid value!'';',
'  end if;',
'end validate;',
''))
,p_api_version=>2
,p_render_function=>'render'
,p_standard_attributes=>'VISIBLE:READONLY:SOURCE:ELEMENT:ELEMENT_OPTION'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'18.2.0'
,p_about_url=>'https://github.com/rafael-trevisan/apex-plugin-simple_checkbox'
,p_files_version=>18
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
