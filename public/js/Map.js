var app = {
    map: null,
    draw: null,
    data: {},
    layers: {},
    colors:{
        Feuerwehr:{
            'fill-color': '#e60005',
            'fill-opacity': 0.5
        },
        THW:{
            'fill-color': '#003399',
            'fill-opacity': 0.5
        },
        Rettungsdienst:{
            'fill-color': '#e6d5a0',
            'fill-opacity': 0.7
        },
        Polizei:{
            'fill-color': '#0055a5',
            'fill-opacity': 0.5
        }
    },

    initMap: function () {
        mapboxgl.accessToken = Config.accessToken;

        this.map = new mapboxgl.Map({
            container: 'map',
            style: Config.style,
            bounds: [[6.874714, 47.510191], [14.600957, 54.841894]],
        });

        this.initMapDraw();

        app.map.addControl(new MapboxLanguage({
            defaultLanguage: 'de'
        }));


        this.map.on('load', function () {
            app.fillMap();
        });
    },
    initMapDraw() {
        app.draw = new MapboxDraw({
            displayControlsDefault: false,
            controls: {
                save: true,
                polygon: true,
                trash: true
            }
        });
        this.map.addControl({
            onAdd(map) {
                this.map = map;
                this.container = document.createElement('div');
                this.container.className = 'mapboxgl-ctrl-group mapboxgl-ctrl';
                this.container.innerHTML = '<button class="mapbox-gl-draw_ctrl-draw-btn mapbox-gl-draw_save" title="Speichern"></button>';
                $(this.container).on('click', function () {
                    app.createArea(app.draw.getAll());
                });
                return this.container;
            },
            onRemove() {
                this.container.parentNode.removeChild(this.container);
                this.map = undefined;
            }
        });
        this.map.addControl(app.draw);


        //this.map.on('draw.create', this.createArea);
        //this.map.on('draw.update', this.updateArea);
        //this.map.on('draw.delete', this.deleteArea);


    },
    areaInfo: function (data) {

        modal.title.text('Bereich anlegen');
        $('> *', modal.body).remove();

        var d = {};
        if (app.data[data.feature.id]) {
            d = app.data[data.feature.id];
        }

        var form = $('<form>');
        modal.body
            .append(form
                .addClass('form-group')
                .append(
                    $('<label>').text('Name').attr('for', 'Name')
                )
                .append(
                    $('<input>').addClass('form-control').attr({
                        type: 'text',
                        maxLength: 256,
                        id: 'Name',
                        name: 'Name'
                    })
                )
            )
            .append($('<div>')
                .addClass('form-group')
                .append(
                    $('<label>').text('Crypto').attr('for', 'Crypto')
                )
                .append(
                    $('<input>').addClass('form-control').attr({
                        type: 'text',
                        maxLength: 128,
                        id: 'Crypto',
                        name: 'Crypto',
                        placeholder: 'Wenn keine Crypto, leer lassen…'
                    })
                )
            )
            .append($('<div>')
                .addClass('form-group')
                .append(
                    $('<label>').text('Baud').attr('for', 'Baud')
                )
                .append(
                    $('<input>').addClass('form-control').attr({
                        type: 'number',
                        maxLength: 6,
                        step: 100,
                        min: 0,
                        max: 999999,
                        id: 'Baud',
                        name: 'Baud'
                    })
                )
            )
            .append($('<div>')
                .addClass('form-group')
                .append(
                    $('<label>').text('Frequenz in Hz').attr('for', 'Frequenz')
                )
                .append(
                    $('<input>').addClass('form-control').attr({
                        type: 'number',
                        maxLength: 10,
                        step: 1000,
                        min: 0,
                        max: 9999999999,
                        id: 'Frequenz',
                        name: 'Frequenz'
                    })
                )
            )
            .append($('<div>')
                .addClass('form-group')
                .append(
                    $('<label>').text('Organisation').attr('for', 'Organisation')
                )
                .append(
                    $('<select>')
                        .addClass('form-control')
                        .attr({
                            id: 'Organisation',
                            name: 'Organisation'
                        })
                        .append($('<option>').attr('value', 'Feuerwehr').text('Feuerwehr'))
                        .append($('<option>').attr('value', 'Rettungsdienst').text('Rettungsdienst'))
                        .append($('<option>').attr('value', 'Polizei').text('Polizei'))
                        .append($('<option>').attr('value', 'THW').text('THW'))
                )
            );

        modal.me.modal('show');


        modal.save.on('click', function () {
            var d = $('input, select', modal.me).serializeArray();
            for (var i in d) {
                if (d.hasOwnProperty(i)) {
                    data[d[i].name] = d[i].value;
                    console.log(d);
                }
            }

            console.log(data);

            $.post('./?controller=Funkbereiche/create', data, function (response) {
                if (response.success && response.data) {
                    app.draw.delete(response.data.P_ID);
                    app.addLayer(response.data);
                    modal.me.modal('hide');
                }
            });
        });
    },
    createArea: function (e) {
        console.log(e);
        if (e.features.length > 0) {
            app.areaInfo({feature: e.features});
        }
    },
    updateArea: function (e) {
        if (e.features.length > 0) {
            console.log(e);
            if (e.features.length > 0) {
                app.areaInfo({feature: e.features});
            }
        }
    },
    deleteArea: function (e) {
        if (e.features.length > 0) {

            var post = {ID: e.features[0].id};
            console.log(post);
        }
    },
    fillMap() {
        $.getJSON('./?controller=Funkbereiche/getAll', function (response) {
            if (response.success && response.data) {
                console.log(response.data);
                for (var i in response.data) {
                    if (response.data.hasOwnProperty(i)) {
                        app.addLayer(response.data[i]);
                    }
                }
            }
        });
    },
    addLayer: function (data) {
        console.log(data)
        app.data[data.ID] = data;
        app.layers[data.ID] = app.map.addLayer(app.createPolygon(data));
        app.map.on('click', data.ID, function (e) {
            console.log(e.features[0].layer.id);
            var data = app.data[e.features[0].layer.id];
            var content = ["<b>" + data.Name + "</b>"];
            if (data.Organisation) {
                content.push("Organisation: " + data.Organisation);
            }
            if (data.Frequenz) {
                content.push("Frequenz: " + data.Frequenz);
            }
            if (data.Frequenz) {
                content.push("Baud: " + data.Baud);
            }
            if (data.Crypto) {
                content.push("Crypto: " + data.Crypto);
            }
            new mapboxgl.Popup()
                .setLngLat(e.lngLat)
                .setHTML(content.join('<br>'))
                .addTo(app.map);
        });
    },
    createPolygon: function (data) {
        return {
            'id': data.ID,
            'type': 'fill',
            'source': {
                'type': 'geojson',
                'data': {
                    'type': 'Feature',
                    'geometry': data.geometry
                },
            },
            'paint': app.colors[data.Organisation]
        };
    }
};
app.initMap();