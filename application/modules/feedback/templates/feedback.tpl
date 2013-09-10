<div id="titleExt">
    <h5><a href="/">Главная</a> / {widget('path')}</h5>
</div>
<h2 class="ext">Обратная связь</h2>

<div class="container">
    <div class="content center">
        <div id="contact">
            <div class="left">

                {if $form_errors}
                    <div class="errors">
                        {$form_errors}
                    </div>
                {/if}

                {if $message_sent}
                    <div style="color: green;">
                        Ваше сообщение отправлено.
                    </div>
                {/if}

                <form action="{site_url('feedback')}" method="post">
                    <div class="textbox" style="margin-top: 15px;">
                        <input type="text" id="name" name="name" class="text" value="{if $_POST.name}{$_POST.name}{/if}"
                               placeholder="Ваше Имя"/>
                    </div>

                    <div class="textbox" style="margin-top: 15px;">
                        <input type="text" id="email" name="email" class="text" value="{if $_POST.email}{$_POST.email}{/if}" placeholder="Email"/>
                    </div>

                    <div class="textbox" style="margin-top: 15px;">
                        <input type="text" id="theme" name="theme" class="text" value="{if $_POST.theme}{$_POST.theme}{/if}" placeholder="Тема"/>
                    </div>

                    <div class="textbox" style="margin-top: 15px;">
                        <textarea cols="45" rows="10" name="message" id="message" placeholder="Текст Сообщения">{if $_POST.message}{$_POST.message}{/if}</textarea>
                    </div>

                    <div style="margin-top: 15px;">
                        {$cap_image}
                    </div>
                    <div class="comment_form_info">
                        {if $captcha_type =='captcha'}
                            <div class="textbox captcha" style="margin-top: 15px;">
                                <input type="text" name="captcha" id="recaptcha_response_field" value="" placeholder="Код протекции"/>
                            </div>
                        {/if}
                    </div>


                    <div style="margin-top: 15px;">
                        <input type="submit" class="submit" value="{lang('lang_comment_button')}" />
                    </div>
                    {form_csrf()}
                </form>
            </div>
            <div class="right">
                <div id="detail">
                    <!--<h2 id="title">Контакты</h2>-->
                    {//widget('contacts')}
                </div>
            </div>
        </div>
    </div>
</div>