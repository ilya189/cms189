{lang('a_select_cat')}:
<select id="move_cat_id">
<option value="0" selected="selected">{lang('a_no')}</option>
{ $this->view("cats_select.tpl", $this->template_vars); }
</select>
<br/>
<br/>
<div align="center">
<input type="submit" name="button"  class="button" value="{lang('a_send')}" onclick="move_to_cat('{$action}'); MochaUI.closeWindow($('move_pages_window')); return false;" />
<input type="submit" name="button"  class="button" value="{lang('a_cancel')}" onclick="MochaUI.closeWindow($('move_pages_window')); return false;" />
</div>
