<div id="titleExt">
    <h5><a href="/">Главная</a> / {widget('path')}</h5>
</div>
<h2 class="ext">Корзина</h2>

{if $cart->total_items() == 0}
    Корзина пуста
    {if $send_message}
        <div class="message">{$send_message}</div>
    {/if}
{else:}
<div class="table-items">
    <form class="submit-cart" action="/basket/submit" method="post">
        <div id="cart_items">
            {$cart_items}
        </div>
        <div id="cart_form">
            {$cart_form}
        </div>
        {form_csrf()}
    </form>
</div>
{/if}

