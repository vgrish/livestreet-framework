{**
 * Выбор местоположения
 *
 * @param string $targetType
 * @param object $place
 * @param array  $countries
 * @param array  $regions
 * @param array  $cities
 *}

{extends './field.tpl'}

{block 'field_options' append}
    {foreach [ 'place', 'countries', 'regions', 'cities', 'targetType' ] as $param}
        {assign var="$param" value=$smarty.local.$param}
    {/foreach}

    {if $targetType}
        {$attributes = array_merge( $attributes|default:[], [ 'data-type' => $targetType ] )}
    {/if}

    {$mods = "$mods geo"}
    {$name = $name|default:'geo'}
{/block}

{block 'field_input'}
    {**
     * Select
     *
     * @param array   $items        Список объектов
     * @param string  $type         Тип объекта
     * @param boolean $display      Отображать селект или нет
     * @param object  $selectedItem Выбранный объект
     *}
    {function field_geo_select items=[] type='' display=true selectedItem=false}
        <select class="{$component}-geo-{$type} js-field-geo-{$type}" name="{$name}_{$type}" {if ! $display}style="display:none;"{/if}>
            <option value="">{lang "field.geo.select_$type"}</option>

            {foreach $items as $item}
                <option value="{$item->getId()}" {if $selectedItem == $item->getId()}selected="selected"{/if}>
                    {$item->getName()}
                </option>
            {/foreach}
        </select>
    {/function}

    {* Страна *}
    {field_geo_select type='country' items=$countries selectedItem=(($place) ? $place->getCountryId() : false)}

    {* Регион *}
    {field_geo_select type='region' items=$regions selectedItem=(($place) ? $place->getRegionId() : false) display=($place && $place->getCountryId())}

    {* Город *}
    {field_geo_select type='city' items=$cities selectedItem=(($place) ? $place->getCityId() : false) display=($place && $place->getRegionId())}
{/block}