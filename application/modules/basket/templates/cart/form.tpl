{if $form_errors}
    <div class="errors">
        {$form_errors}
    </div>
{/if}

<h3 style="margin:20px 0 0 0; font-size:20px;">Оформление заказа</h3>
<div>
    <i class="small">Чтобы отправить заказ, заполните пожалуйста форму. Поля отмеченные *, обязательны для заполнения.</i>
</div>
<div class="form-wrapper">
    <div class="form-title">ФИО*:</div>
    <div class="form-input">
        <input {if $error_fio}class="error"{/if} id="fio" type="text" onkeyup="keyup(this)" value="{$fio}" name="fio">
    </div>
</div>
<div class="form-wrapper">
    <div class="form-title">Организация:</div>
    <div class="form-input">
        <input {if $error_org}class="error"{/if} id="org" type="text" onkeyup="keyup(this)" value="{$org}" name="org">
    </div>
</div>
<div class="form-wrapper">
    <div class="form-title">Телефон*:</div>
    <div class="form-input">
        <input {if $error_phone}class="error"{/if} id="phone" type="text" onkeyup="keyup(this)" value="{$phone}" name="phone">
    </div>
</div>
<div class="form-wrapper">
    <div class="form-title">E-mail:</div>
    <div class="form-input">
        <input {if $error_email}class="error"{/if} id="email" type="text" onkeyup="keyup(this)" value="{$email}" name="email">
    </div>
</div>
<div class="form-wrapper">
    <div class="form-title">Адрес доставки:</div>
    <div class="form-input">
        <input {if $error_toadres}class="error"{/if} id="toadres" type="text" onkeyup="keyup(this)" value="{$toadres}" name="toadres">
    </div>
</div>
<div class="form-wrapper">
    <div class="form-title">Комментарии к заказу:</div>
    <div class="form-input">
        <textarea {if $error_comment}class="error"{/if} id="comment" onkeyup="keyup(this)" name="comment" rows="" cols="">{$comment}</textarea>
    </div>
</div>
<div class="cart-submit">
    <img class="submit-load" src="{$THEME}images/ajax-loader.gif" style="display:none;">
    <input class="button" type="submit" value="Заказать">
</div>