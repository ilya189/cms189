<div id="titleExt">
    <h5><a href="/">Главная</a> / {widget('path')}</h5>
</div>
<h2 class="ext">Фотогалерея</h2>

{foreach $gallery_category as $category}
    <div class="album-list shadow">
        <a class="ph" href="{site_url('gallery/category/' . $category.id)}">{$category.name}</a>
        <div class="gall-small">(Альбомов: {$category.albums_count})</div>
        <div>
            {$category.description}
        </div>
    </div>
    <br />
{/foreach}
