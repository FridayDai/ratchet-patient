<div class="list-container">
    %{--for active--}%
    <div>
        <div class="top-line"></div>

        <g:render template="/clinicTask/template/taskItem" model="[status: 'complete']"/>
        <g:render template="/clinicTask/template/taskItem" model="[status: 'complete']"/>

    </div>

    %{--for all tasks--}%
    <div>
        <g:render template="/clinicTask/template/taskItem" model="[status: 'complete']"/>
        <g:render template="/clinicTask/template/taskItem" model="[status: 'complete']"/>

        <g:render template="/clinicTask/template/taskItem" model="[status: 'active']"/>
        <g:render template="/clinicTask/template/taskItem" model="[status: 'active']"/>

        <g:render template="/clinicTask/template/taskItem" model="[status: 'schedule']"/>
        <g:render template="/clinicTask/template/taskItem" model="[status: 'schedule']"/>

        <div class="more-text">And More</div>
    </div>
</div>

