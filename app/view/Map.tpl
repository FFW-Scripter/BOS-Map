<!Doctype HTML>
<html lang="de">
<head>
    <title>BOS-Map</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.min.css">
    <link href='https://api.tiles.mapbox.com/mapbox-gl-js/v1.1.0/mapbox-gl.css' rel='stylesheet'/>
    <link rel='stylesheet' href='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.0.9/mapbox-gl-draw.css'
          type='text/css'/>
    <style type="text/css">
        html, body, #map {
            width: 100%;
            height: 100%;
        }
        .mapbox-gl-draw_save{
            background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4KCjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgdmVyc2lvbj0iMS4xIgogICBpZD0iQ2FwYV8xIgogICB4PSIwcHgiCiAgIHk9IjBweCIKICAgd2lkdGg9IjIwIgogICBoZWlnaHQ9IjIwLjAwMDI3MSIKICAgdmlld0JveD0iMCAwIDIwIDIwLjAwMDI3MSIKICAgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIKICAgc29kaXBvZGk6ZG9jbmFtZT0ic2F2ZS1maWxlLW9wdGlvbi5zdmciCiAgIGlua3NjYXBlOnZlcnNpb249IjAuOTIuMyAoMjQwNTU0NiwgMjAxOC0wMy0xMSkiPjxtZXRhZGF0YQogICBpZD0ibWV0YWRhdGE0MSI+PHJkZjpSREY+PGNjOldvcmsKICAgICAgIHJkZjphYm91dD0iIj48ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD48ZGM6dHlwZQogICAgICAgICByZGY6cmVzb3VyY2U9Imh0dHA6Ly9wdXJsLm9yZy9kYy9kY21pdHlwZS9TdGlsbEltYWdlIiAvPjxkYzp0aXRsZT48L2RjOnRpdGxlPjwvY2M6V29yaz48L3JkZjpSREY+PC9tZXRhZGF0YT48ZGVmcwogICBpZD0iZGVmczM5IiAvPjxzb2RpcG9kaTpuYW1lZHZpZXcKICAgcGFnZWNvbG9yPSIjZmZmZmZmIgogICBib3JkZXJjb2xvcj0iIzY2NjY2NiIKICAgYm9yZGVyb3BhY2l0eT0iMSIKICAgb2JqZWN0dG9sZXJhbmNlPSIxMCIKICAgZ3JpZHRvbGVyYW5jZT0iMTAiCiAgIGd1aWRldG9sZXJhbmNlPSIxMCIKICAgaW5rc2NhcGU6cGFnZW9wYWNpdHk9IjAiCiAgIGlua3NjYXBlOnBhZ2VzaGFkb3c9IjIiCiAgIGlua3NjYXBlOndpbmRvdy13aWR0aD0iMTkyMCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iMTAxNSIKICAgaWQ9Im5hbWVkdmlldzM3IgogICBzaG93Z3JpZD0iZmFsc2UiCiAgIGZpdC1tYXJnaW4tdG9wPSIwIgogICBmaXQtbWFyZ2luLWxlZnQ9IjAiCiAgIGZpdC1tYXJnaW4tcmlnaHQ9IjAiCiAgIGZpdC1tYXJnaW4tYm90dG9tPSIwIgogICBpbmtzY2FwZTp6b29tPSIwLjUzODE1NzkyIgogICBpbmtzY2FwZTpjeD0iLTI2LjAxNzY2OSIKICAgaW5rc2NhcGU6Y3k9IjIxOS4yNjc1IgogICBpbmtzY2FwZTp3aW5kb3cteD0iMzIwMCIKICAgaW5rc2NhcGU6d2luZG93LXk9IjAiCiAgIGlua3NjYXBlOndpbmRvdy1tYXhpbWl6ZWQ9IjEiCiAgIGlua3NjYXBlOmN1cnJlbnQtbGF5ZXI9IkNhcGFfMSIgLz4KPGcKICAgaWQ9Imc0IgogICB0cmFuc2Zvcm09Im1hdHJpeCgwLjA0NTYwNzEyLDAsMCwwLjA0NTYwNzEyLC0xLjM2ODIxMzZlLTQsLTIuNzUwODU0NWUtNikiPgoJPHBhdGgKICAgZD0ibSA0MzIuODIzLDEyMS4wNDkgYyAtMy44MDYsLTkuMTMyIC04LjM3NywtMTYuMzY3IC0xMy43MDksLTIxLjY5NSBMIDMzOS4xNzMsMTkuNDEyIEMgMzMzLjg0OCwxNC4wODcgMzI2LjYxMyw5LjUxNyAzMTcuNDc3LDUuNzA4IDMwOC4zNDYsMS45MDMgMjk5Ljk2OSwwIDI5Mi4zNTcsMCBIIDI3LjQwOSBDIDE5Ljc5OCwwIDEzLjMyNSwyLjY2MyA3Ljk5NSw3Ljk5MyAyLjY2NSwxMy4zMiAwLjAwMywxOS43OTIgMC4wMDMsMjcuNDA3IHYgMzgzLjcxOSBjIDAsNy42MTcgMi42NjIsMTQuMDg5IDcuOTkyLDE5LjQxNyA1LjMzLDUuMzI1IDExLjgwMyw3Ljk5MSAxOS40MTQsNy45OTEgaCAzODMuNzE4IGMgNy42MTgsMCAxNC4wODksLTIuNjY2IDE5LjQxNywtNy45OTEgNS4zMjUsLTUuMzI4IDcuOTg3LC0xMS44IDcuOTg3LC0xOS40MTcgViAxNDYuMTc4IGMgMCwtNy42MTYgLTEuOTAyLC0xNS45OSAtNS43MDgsLTI1LjEyOSB6IE0gMTgyLjcyNSw0NS42NzcgYyAwLC0yLjQ3NCAwLjkwNSwtNC42MTEgMi43MTQsLTYuNDIzIDEuODA3LC0xLjgwNCAzLjk0OSwtMi43MDggNi40MjMsLTIuNzA4IGggNTQuODE5IGMgMi40NjgsMCA0LjYwOSwwLjkwMiA2LjQxNywyLjcwOCAxLjgxMywxLjgxMiAyLjcxNywzLjk0OSAyLjcxNyw2LjQyMyB2IDkxLjM2MiBjIDAsMi40NzggLTAuOTEsNC42MTggLTIuNzE3LDYuNDI3IC0xLjgwOCwxLjgwMyAtMy45NDksMi43MDggLTYuNDE3LDIuNzA4IGggLTU0LjgxOSBjIC0yLjQ3NCwwIC00LjYxNywtMC45MDIgLTYuNDIzLC0yLjcwOCAtMS44MDksLTEuODEyIC0yLjcxNCwtMy45NDkgLTIuNzE0LC02LjQyNyBWIDQ1LjY3NyBaIE0gMzI4LjkwNiw0MDEuOTkxIEggMTA5LjYzMyBWIDI5Mi4zNTUgaCAyMTkuMjczIHogbSA3My4wOTQsMCBoIC0zNi41NTIgLTAuMDA3IFYgMjgzLjIxOCBjIDAsLTcuNjE3IC0yLjY2MywtMTQuMDg1IC03Ljk5MSwtMTkuNDE3IC01LjMyOCwtNS4zMjggLTExLjgsLTcuOTk0IC0xOS40MSwtNy45OTQgSCAxMDAuNDk4IGMgLTcuNjE0LDAgLTE0LjA4NywyLjY2NiAtMTkuNDE3LDcuOTk0IC01LjMyNyw1LjMyOCAtNy45OTIsMTEuOCAtNy45OTIsMTkuNDE3IFYgNDAxLjk5MSBIIDM2LjU0NCBWIDM2LjU0MiBoIDM2LjU0NCB2IDExOC43NzEgYyAwLDcuNjE1IDIuNjYyLDE0LjA4NCA3Ljk5MiwxOS40MTQgNS4zMyw1LjMyNyAxMS44MDMsNy45OTMgMTkuNDE3LDcuOTkzIGggMTY0LjQ1NiBjIDcuNjEsMCAxNC4wODksLTIuNjY2IDE5LjQxLC03Ljk5MyA1LjMyNSwtNS4zMjcgNy45OTQsLTExLjc5OSA3Ljk5NCwtMTkuNDE0IFYgMzYuNTQyIGMgMi44NTQsMCA2LjU2MywwLjk1IDExLjEzNiwyLjg1MyA0LjU3MiwxLjkwMiA3LjgwNiwzLjgwNSA5LjcwOSw1LjcwOCBsIDgwLjIzMiw4MC4yMyBjIDEuOTAyLDEuOTAzIDMuODA2LDUuMTkgNS43MDgsOS44NTEgMS45MDksNC42NjUgMi44NTcsOC4zMyAyLjg1NywxMC45OTQgdiAyNTUuODEzIHoiCiAgIGlkPSJwYXRoMiIKICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz4KPC9nPgo8ZwogICBpZD0iZzYiCiAgIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjAwMywtNDE4LjUzMzcyKSI+CjwvZz4KPGcKICAgaWQ9Imc4IgogICB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC4wMDMsLTQxOC41MzM3MikiPgo8L2c+CjxnCiAgIGlkPSJnMTAiCiAgIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjAwMywtNDE4LjUzMzcyKSI+CjwvZz4KPGcKICAgaWQ9ImcxMiIKICAgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuMDAzLC00MTguNTMzNzIpIj4KPC9nPgo8ZwogICBpZD0iZzE0IgogICB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC4wMDMsLTQxOC41MzM3MikiPgo8L2c+CjxnCiAgIGlkPSJnMTYiCiAgIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjAwMywtNDE4LjUzMzcyKSI+CjwvZz4KPGcKICAgaWQ9ImcxOCIKICAgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuMDAzLC00MTguNTMzNzIpIj4KPC9nPgo8ZwogICBpZD0iZzIwIgogICB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC4wMDMsLTQxOC41MzM3MikiPgo8L2c+CjxnCiAgIGlkPSJnMjIiCiAgIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjAwMywtNDE4LjUzMzcyKSI+CjwvZz4KPGcKICAgaWQ9ImcyNCIKICAgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuMDAzLC00MTguNTMzNzIpIj4KPC9nPgo8ZwogICBpZD0iZzI2IgogICB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC4wMDMsLTQxOC41MzM3MikiPgo8L2c+CjxnCiAgIGlkPSJnMjgiCiAgIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjAwMywtNDE4LjUzMzcyKSI+CjwvZz4KPGcKICAgaWQ9ImczMCIKICAgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuMDAzLC00MTguNTMzNzIpIj4KPC9nPgo8ZwogICBpZD0iZzMyIgogICB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC4wMDMsLTQxOC41MzM3MikiPgo8L2c+CjxnCiAgIGlkPSJnMzQiCiAgIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjAwMywtNDE4LjUzMzcyKSI+CjwvZz4KPC9zdmc+ ');
            background-size: 16px;
        }
    </style>
</head>
<body>
<section id="map">

</section>

{include 'Modal.tpl'}

<script>
    var Config = {json_encode($Config)};
</script>

<script src='js/jquery-3.4.1.min.js'></script>
<script src='https://api.tiles.mapbox.com/mapbox-gl-js/v1.1.0/mapbox-gl.js'></script>
<script src='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.0.9/mapbox-gl-draw.js'></script>
<script src='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-language/v0.10.0/mapbox-gl-language.js'></script>

<script src="js/bootstrap.bundle.min.js"></script>
<script src="js/Modal.js"></script>
<script src="js/Map.js"></script>


</body>
</html>