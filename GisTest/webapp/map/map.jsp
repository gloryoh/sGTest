<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->

    <link rel="stylesheet" type="text/css" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="/resources/map/css/ol.css">

    <script type="text/javascript" src="/resources/js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="/resources/map/ol/ol.js"></script>
    <script type="text/javascript" src="/resources/map/GeoJson.js"></script>
    <script type="text/javascript" src="/resources/map/proj4js/proj4.js"></script>

<!--     <script type="text/javascript" src="/resources/map/ol/ol-debug.js"></script> -->

     <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script type="text/javascript">

    //현재 뷰의 중심점 설정
    function changeCenter(center) {
        center = center || [13621512.686098237, 4860819.887277769];
        map.getView().setCenter( center );
    }

    </script>

<title>Insert title here</title>
</head>
<body>
     <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Dashboard</a></li>
            <li><a href="#">Settings</a></li>
            <li><a href="#">Profile</a></li>
            <li><a href="#">Help</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li>
            <li><a href="javascript:changeCenter();">changeCenters</a></li>
            <li><a href="#">Analytics</a></li>
            <li><a href="#">Export</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item</a></li>
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
            <li><a href="">More navigation</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
          </ul>
        </div>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">MAP</h1>
            <div class="map"  id="map"></div>
            <button id="goVworld">Vworldd</button>

            <label>Measurement type &nbsp;</label>
            <select id="type">
              <option value="length">Length (LineString)</option>
              <option value="area">Area (Polygon)</option>
            </select>
            <label class="checkbox"><input type="checkbox" id="geodesic">use geodesic measures</label>
        </div>
      </div>
    </div>

    <script type="text/javascript">

    document.getElementById('goVworld').onclick = function() {
        alert( "go Vworldd....!! ");
        setTileVworld("H");
      };

        // U-City 지도
        proj4.defs("EPSG:5179","+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
        ol.proj.get("EPSG:5179").setExtent( [890135.80436699, 1920393.61802171, 948344.25411722, 1965478.7081919] );

        // 다음지도
        proj4.defs("EPSG:5181","+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
        ol.proj.get("EPSG:5181").setExtent( [-30000, -60000, 494288, 988576] );

        // vworld 지도
        proj4.defs('EPSG:900913','+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs');
        ol.proj.get('EPSG:900913').setExtent( [-20037508.34, -20037508.34, 20037508.34, 20037508.34] );

        /* var map = new ol.Map({
            layers: [
              new ol.layer.Tile({
                source: new ol.source.OSM()
              })
            ],
            target: 'map',
            controls: ol.control.defaults({ */
              //attributionOptions: /** @type {olx.control.AttributionOptions} */ ({
                /*collapsible: false
              })
            }),
            view: new ol.View({
              //center: [0, 0],
              center: ol.proj.transform([126.9783882, 37.5666103], 'EPSG:4326', 'EPSG:3857'),
              zoom: 6
            })
          }); */

       /*   var map = new ol.Map({
            target : 'map',
            renderer : 'canvas'
        });

        //mapPanel -> view
        var view = new ol.View({
            projection : 'EPSG:3857',
            center: ol.proj.transform([126.9783882, 37.5666103], 'EPSG:4326', 'EPSG:3857'),
            zoom: 6
        });

        var osmSource = new ol.source.OSM();
        var osmLayer = new ol.layer.Tile({
            source: osmSource
        });

        map.setView( view );
        map.addLayer( osmLayer ); */
        //alert(view.getProjection());


        var view = new ol.View({
            projection : 'EPSG:5179',   //me.getProjection(),
            center: [919341.07208, 1941698.02606],   //me.getMapCenter(),
            zoom: 3,
            minZoom: 2,
            maxZoom: 14 //me.getMaxZoom(),
        });

      var vworldApiKey = "93A3FF65-E3BF-3F1A-AC9A-FA9E40D354FD";
      var VWORLD_SOURCE = null;

      var IUCITY_SOURCE = new ol.source.WMTS({
          url:  'http://192.168.1.14:8099/wmts?',
          layer: 'S$IUCITY_TILES',
          matrixSet: 'S$IUCITY_TILES_MATRIXSET',
          format: 'image/png',
          projection: ol.proj.get('EPSG:5179'),
          tileGrid: new ol.tilegrid.WMTS({
            origins:[
                    [890135.80436699, 2004361.61802171],
                    [890135.80436699, 1983369.61802171],
                    [890135.80436699, 1972873.61802171],
                    [890135.80436699, 1967625.61802171],
                    [890135.80436699, 1967625.61802171],
                    [890135.80436699, 1966313.61802171],
                    [890135.80436699, 1965657.61802171],
                    [890135.80436699, 1965657.61802171],
                    [890135.80436699, 1965493.61802171],
                    [890135.80436699, 1965493.61802171]
                    ],
            resolutions: [82.0, 41.0, 20.5, 10.25, 5.125, 2.5625, 1.28125, 0.640625, 0.3203125, 0.16015625],
            tileSize: 512,
            matrixIds: ['L0','L1','L2','L3','L4','L5','L6','L7','L8','L9']

          }),
        style: 'default',
        crossOrigin:'anonymous'
      });

    var MAP_TILES = new ol.layer.Tile({ //
        source: IUCITY_SOURCE,
    });

    var SAT_TILES = new ol.layer.Tile();

    var olMap = new ol.Map({
      target : 'map',
        interactions : ol.interaction.defaults({doubleClickZoom :false}),
          layers : [SAT_TILES, MAP_TILES],
          controls : ol.control.defaults().extend([
              new ol.control.Zoom(),
              new ol.control.ZoomSlider(),
              new ol.control.ZoomToExtent(),
              new ol.control.ScaleLine(),
              new ol.control.FullScreen(),
              //overviewMapControl//new ol.control.OverviewMap()
          ]),
          renderer: 'canvas'
      });

    //me.setMap(olMap);
    olMap.setView( view );

    //vworld 베이스맵 설정
      function setTileVworld(mapType){
        /* var me = this;
        me.lookupReference('indexMapPanel').hide(); */
        //var mapPanel = me.lookupReference('mapPanel');
        //var olMap = mapPanel.getMap();

        var attribution = new ol.Attribution({
            html: 'Copyright:&copy; VWorld Map'
        });

        var center = ol.proj.transform(olMap.getView().getCenter(), view.getProjection().getCode(), 'EPSG:900913');
        //view.setProjection(ol.proj.get('EPSG:900913'));
        view.setProperties("projection", ol.proj.get('EPSG:900913'));

        var vUrl;
        var vUrlSat;
        if(mapType == 'S'){
            //view.setMaxZoom(19);
            vUrl = 'http://xdworld.vworld.kr:8080/2d/Satellite/201301/{z}/{x}/{y}.jpeg';
            VWORLD_SOURCE = new ol.source.XYZ({
                attributions: [attribution],
                url: vUrl
            });
            VWORLD_SAT_SOURCE = new ol.source.XYZ({
                url: ''
            });
        }else if(mapType == 'H'){
            //view.setMaxZoom(19);
            vUrl = 'http://xdworld.vworld.kr:8080/2d/Hybrid/201411/{z}/{x}/{y}.png';
            vUrlSat = 'http://xdworld.vworld.kr:8080/2d/Satellite/201301/{z}/{x}/{y}.jpeg';
            VWORLD_SOURCE = new ol.source.XYZ({
                attributions: [attribution],
                url: vUrl
            });
            VWORLD_SAT_SOURCE = new ol.source.XYZ({
                url: vUrlSat
            });
            SAT_TILES.setSource(VWORLD_SAT_SOURCE);
        }else{
            //view.setMaxZoom(19);
            vUrl = 'http://xdworld.vworld.kr:8080/2d/Base/201411/{z}/{x}/{y}.png';
            VWORLD_SOURCE = new ol.source.XYZ({
                attributions: [attribution],
                url: vUrl
            });
            VWORLD_SAT_SOURCE = new ol.source.XYZ({
                url: ''
            });
        }

        MAP_TILES.setSource(VWORLD_SOURCE);

        var vworldView = new ol.View({
              minZoom : 1,
              maxZoom : 14,  //view.getMaxZoom(),
              projection: ol.proj.get('EPSG:900913'),    //view.getProjection(),    //view.getProperties("projection"),
              center: ol.proj.transform([126.579936, 37.478991], 'EPSG:4326', 'EPSG:900913'),
              extent:  [-20037508.34, -20037508.34, 20037508.34, 20037508.34]       //ol.proj.get('EPSG:900913').getExtents();
        });

        olMap.setView(vworldView);
        olMap.getView().setCenter(center);
        olMap.getView().setZoom(12);

        //osmLayer.setSource(VWORLD_SOURCE);
        //map.addLayer( MAP_TILES );    뒤에 깔림
    }
    </script>

</body>
</html>