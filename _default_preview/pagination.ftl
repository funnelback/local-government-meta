
<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
    Contains the markup and logic to display the pagination feature.
    Relies on the pagination plugin to be enabled.
-->

<#--
  Display paging controls.
-->
<#macro Pagination>
    <!-- pagination::Pagination -->
    <div>
        <#-- Previous page -->
        <nav class="pagination" role="navigation" aria-label="Pagination navigation">
            <#if (response.customData.stencils.pagination.previous)??>
                <div class="pagination__item pagination__item--previous">
                    <a class="pagination__link" rel="prev nofollow" href="${(response.customData.stencils.pagination.previous.url)!}" aria-label="Goto previous page">
                        <svg aria-hidden="true" class="svg-icon">
                            <use href="#chevron"></use>
                        </svg>
                        <span class="pagination__label">
                            ${(response.customData.stencils.pagination.previous.label)!"Prev"}
                        </span>
                    </a>
                </div>
            </#if>

            <#-- Sibling pages - Should only be visibile on desktop -->
            <#if (response.customData.stencils.pagination.pages)!?has_content &&
                response.customData.stencils.pagination.pages?size gt 1>
                <ul class="pagination__list">
                    <#list response.customData.stencils.pagination.pages as page>
                        <#if page.selected>
                            <li class="pagination__item pagination__item--current" aria-current="true">
                                <span class="pagination__link">
                                    <span class="pagination__label">
                                        <span class="sr-only">Current Page, Page </span>
                                        ${page.label} 
                                    </span>
                                </span>
                            </li>
                        <#else>                             
                            <li class="pagination__item">
                                <a class="pagination__link" rel="nofollow" href="${page.url}" aria-label="Goto Page 1">
                                    <span class="pagination__label">${page.label}</span>
                                </a>
                            </li>
                        </#if>
                    </#list>                    
                </ul>
            </#if>

            <#-- Next page -->
            <#if (response.customData.stencils.pagination.next)??>            
                <div class="pagination__item pagination__item--next">
                    <a class="pagination__link" 
                        rel="next nofollow" 
                        href="${(response.customData.stencils.pagination.next.url)!}"
                        aria-label="Goto next page">
                        <span class="pagination__label">
                            ${(response.customData.stencils.pagination.next.label)!"Next"}
                        </span>
                        <svg aria-hidden="true" class="svg-icon">
                            <use href="#chevron"></use>
                        </svg>
                    </a>
                </div>
            </#if> 
        </nav>
    </div>
</#macro>
