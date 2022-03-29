<#ftl encoding="utf-8" output_format="HTML" />
<#import "base.ftl" as base />

<#-- 
	Macro decides how each result should be presented. 

	@param result An individual result fron the data model
	@param view An uppercase string which represents how
		the result should be displayed. Defaults to LIST.
-->
<#macro Result result=result view="LIST">
	<#switch view?upper_case>
		<#case "CARD">
			<@CardView result=result />
			<#break>
		<#case "LIST">
			<#-- Determine if results should be hidden or not -->
			<@ListView result=result />
			<#break>
		<#default>
			<@ListView result=result />
	</#switch>
</#macro>

<#--
	Stardard view of a result which is to be displayed in the 
	main section of the search engine result page (SERP)
	@param result An individual result fron the data model
-->
<#macro ListView result>
	<@GenericView result=result />
</#macro>

<#--
	Card view of a result which is to be displayed in the 
	main section of the search engine result page (SERP)
	@param result An individual result fron the data model
-->
<#macro CardView result>
	<@GenericView result=result />
</#macro>

<#--
	A generic view used to drive both the the list and card view
	@param result An individual result fron the data model
-->
<#macro GenericView result >
    <!-- roadworks.GenericView -->
    <article class="search-results__item search-results__item--people" data-fb-result="${result.indexUrl}">
        <figure class="search-results__bg">
            <#if (result.listMetadata["image"]?first)!?has_content>
                <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="https://jobs.ama.org${result.listMetadata["image"]?first}"> 
            <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
                <img alt="Thumbnail for ${result.title!}" src="https://picsum.photos/300/300?sig=${(result.listMetadata['roadworksStreet']?first)!''?url}"> 
            </#if>
        </figure>
        <div class="search-results__content">
            <h3 class="search-results__title">
                <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}" class="search-results__link">
                    <@s.boldicize>
                        <@s.Truncate length=90>
                            ${(result.listMetadata["roadworksStreet"]?first)!}
                        </@s.Truncate>
                    </@s.boldicize>
                </a>
            </h3>
            
            <#-- Subtitle -->
            <span class="search-results__sub-title">
                                
            </span>
            
            <#-- Summary -->
            <p class="search-results__desc">
                <@s.boldicize>
                    ${result.summary!?no_esc}
                </@s.boldicize>
            </p>

            <section class="tags">
                <ul class="tags__list">
                    <li class="tags__item">
                        ${(result.listMetadata["roadworksWorkStatus"]?first)!}
                    </li>
                    <li class="tags__item">
                        ${(result.listMetadata["roadworksCategoryOfWorks"]?first)!}
                    </li>
                </ul>
            </section>

            <@history_cart.LastVisitedLink result=result/>

            <div class="search-results__bottom">
                <section class="contact js-contact">
                    <ul class="contact__list">                        
                        <#if (result.listMetadata["roadworksStartDate"]?first)!?has_content>
                           <li class="contact__item">
                                <span class="search-results__icon--red far fa-clock" title="Start date"></span>
                                ${(result.listMetadata["roadworksStartDate"]?first)!}
                            </li>
                        </#if>                        
                        
                        <#if (result.listMetadata["roadworksContactTelephoneNumber"]?first)!?has_content>
                            <li class="contact__item contact__item--icon contact__item--icon-phone">
                                <a href="tel:${(result.listMetadata["roadworksContactTelephoneNumber"]?first)!}" class="contact__link">
                                    ${(result.listMetadata["roadworksContactTelephoneNumber"]?first)!}
                                </a>
                            </li>
                        </#if>

                        <#if (result.listMetadata["roadworksLocality"]?first)!?has_content>
                            <li class="contact__item contact__item--icon contact__item--icon-location">
                                ${(result.listMetadata["roadworksLocality"]?first)!}
                            </li>
                        </#if>                        
                    </ul>
                </section>
            </div>
        </div>
    </article>
</#macro>

<#--
* Generates a "random" integer between min and max (inclusive)
*
* Note the values this function returns are based on the current
* second the function is called and thus are highly deterministic
* and SHOULD NOT be used for anything other than inconsequential
* purposes, such as picking a random image to display.
-->
<#function rand min max>
	<#local now = .now?long?c />
	<#local randomNum = _rand +
		("0." + now?substring(now?length-1) + now?substring(now?length-2))?number />
	<#if (randomNum > 1)>
		<#assign _rand = randomNum % 1 />
	<#else>
		<#assign _rand = randomNum />
	</#if>
	<#return (min + ((max - min) * _rand))?round />
</#function>
<#assign _rand = 0.36 />