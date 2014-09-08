var nearBy = document.getElementById("nearbyBuildings");

function fromLatLngToPoint(latLng, map) {
    var topRight = map.getProjection().fromLatLngToPoint(
        map.getBounds().getNorthEast());
    var bottomLeft = map.getProjection().fromLatLngToPoint(
        map.getBounds().getSouthWest());
    var scale = Math.pow(2, map.getZoom());
    var worldPoint = map.getProjection().fromLatLngToPoint(latLng);
    return new google.maps.Point((worldPoint.x - bottomLeft.x) * scale, (worldPoint.y - topRight.y) * scale);
}

function manuplateLineChartCallback(d, status, o) {
    if (/success/i.test(status) === true && d && d.constructor === Array) {
        if (d.length > 0) {
            var dataArray = [];
            dataArray.push(["Transaction Date", "Price"]);
            for (var dt = 0; dt < d.length; dt++) {
                var ds = [];
                ds.push(d[dt]["tran_date"]);
                ds.push(parseFloat(d[dt]["Price_sqft"]));
                dataArray.push(ds);
            }
            (function drawChart_Line() {
                var data = google.visualization.arrayToDataTable(dataArray);
                var options = {
                    title: 'Buidling',
                    curveType: 'function'
                };
                var chart = new google.visualization.LineChart(document.getElementById('divLinechart'));
                chart.draw(data, options);
            })();
        } else {
            document.getElementById('divLinechart').innerHTML = "No Records for Linechart.";
        }
    } else {
        alert("Message: " + o);
    }
}

function manuplateLineChart(building) {
   ////  building = "Acacia";
    invokeService("ActionServlet", "get", {
            serviceName: "getLineChartDataByBuilding",
            building: building
        }, manuplateLineChartCallback,
        manuplateLineChartCallback);
}

function getMapDataCallback(d, status, o) {
    if (/success/i.test(status) === true) {
        var bound = new google.maps.LatLngBounds();
        var nearbyContent = "";
        for (var di = 0; di < d.length; di++) {
            d[di].id = parseInt(d[di].id, 10);
            if (d[di].Latitude && d[di].Longitude) {
                d[di].Latitude = parseFloat(d[di].Latitude);
                d[di].Longitude = parseFloat(d[di].Longitude);
                bound.extend(new google.maps.LatLng(d[di].Latitude, d[di].Longitude));
                nearbyContent += "<div id='' style='float:left;'>" +
                    "<div style='float:left;'><img src='" + d[di].ImageLink + "' height='100' width='100' /></div>" +
                    "<div style='padding:2px 0 2px 10px; float:left'>Building: <a href='#' >" + d[di].Building + " </a></div><br />" +
                    "<div style='padding:2px 0 2px 10px;float:left'>Price/SqFt: " + d[di].Price_sqft + "</div><br />" +
                    "<div style='padding:2px 0 2px 10px;float:left'>Year: " + d[di].Completion + ". Floors: " + d[di].Floors + "</div><br />" +
                    "</div>";
            }
        }
        nearBy.innerHTML = nearbyContent;

        (function drawChart() {
            var mapOptions = {
                zoom: 12,
                center: bound.getCenter()
            };
            var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
            var infowindow = new google.maps.InfoWindow({
                maxWidth: 720
            });
            var infowindow_tooltip = new google.maps.InfoWindow({
                zIndex: 999
            });

            function setMarkers(map, markers) {
                for (var i = 0; i < markers.length; i++) {
                    var sites = markers[i];
                    if (sites.Latitude && sites.Latitude > 0 && sites.Longitude && sites.Longitude > 0) {
                        //console.log("sites.Latitude: ", sites.Latitude);
                        //console.log("sites.Longitude: ", sites.Longitude);
                        var markerOptions = {
                            position: siteLatLng,
                            map: map,
                            icon: 'map_images/Circle_Red_Small.png',
                            draggable: false,
                            zIndex: sites.id,
                            html: sites.Area,
                            labelContent: "AED " + sites.Price_sqft,
                            labelAnchor: new google.maps.Point(20, -7),
                            labelClass: "labels",
                        };
                        for (var sitesKey in sites) {
                            markerOptions[sitesKey] = sites[sitesKey];
                        }
                        var siteLatLng = new google.maps.LatLng(sites.Latitude, sites.Longitude);
                        var marker = new MarkerWithLabel(markerOptions);
                        google.maps.event.addListener(marker, 'mouseover', function() {
                            this.setIcon("map_images/Circle_Green_Small.png");
                            for (var i = 0; i < markers.length; i++) {
                                jQuery('div[title="' + markers[i].Building + '"]').removeAttr(
                                    "class");
                                jQuery('div[title="' + markers[i].Building + '"]').addClass(
                                    "labels");
                                jQuery('div[title="' + this.Building + '"]').addClass(
                                    "labels_active");
                            }
                            var tootltipContent = "<div id='infoContainer'>" +
                                "<div style='float:left;'><img src='" + this.ImageLink + "' height='100' width='100' /></div>" +
                                "<div style='padding:2px 0 2px 10px; float:left'>Building: <a href='#' >" + this.Building + " </a></div><br />" +
                                "<div style='padding:2px 0 2px 10px;float:left'>Price/SqFt: " + this.Price_sqft + "</div><br />" +
                                "<div style='padding:2px 0 2px 10px;float:left'>Year: " + this.Completion + ". Floors: " + this.Floors + "</div><br />" +
                                "</div>";
                            infowindow_tooltip.setContent("&nbsp;&nbsp;&nbsp;" + tootltipContent);
                            infowindow_tooltip.open(map, this);
                        });
                        google.maps.event.addListener(marker, "click", function(event) {
                            manuplateLineChart(this.Building);
                            document.getElementById("tdBuilding").innerHTML = this.Building;
                            document.getElementById("tdArea").innerHTML = this.Area;
                            document.getElementById("tdSubArea").innerHTML = this.Sub_Area;
                            document.getElementById("tdBuildingType").innerHTML = this.Building_Type;
                            document.getElementById("tdBuildingStatus").innerHTML = this.Building_Status;
                            document.getElementById("tdStructualMaterial").innerHTML = this.Structural_Material;
                            document.getElementById("tdArchitecturalStyle").innerHTML = this.Architectural_Style;
                            document.getElementById("tdUsage").innerHTML = this.UsageType;
                            document.getElementById("tdHeight").innerHTML = this.Height;
                            document.getElementById("tdFloors").innerHTML = this.Floors;
                            document.getElementById("tdCompletionDate").innerHTML = this.Completion;
                            document.getElementById("tdElevators").innerHTML = this.Elevators;
                            document.getElementById("tdParking").innerHTML = this.Parking;
                            document.getElementById("tdArchitect").innerHTML = this.Architect;
                            document.getElementById("tdDeveloper").innerHTML = this.Developer;
                            document.getElementById("tdContrctor").innerHTML = this.Contractor;
                            document.getElementById("tdAmenities").innerHTML = "";
                            document.getElementById("tdSurroundingAmenities").innerHTML = "";
                            jQuery("#divFactSheet").show();
                            //                            var infoContent = "<div id='infoContainer'>" +
                            //                                "<div style='float:left;'><img src='" + this.ImageLink + "' height='100' width='100' /></div>" +
                            //                                "<div style='padding:2px 0 2px 10px; float:left'>Building: <a href='#' >" + this.Building + " </a></div><br />" +
                            //                                "<div style='padding:2px 0 2px 10px;float:left'>Price/SqFt: " + this.Price_sqft + "</div><br />" +
                            //                                "<div style='padding:2px 0 2px 10px;float:left'>Year: " + this.Completion + ". Floors: " + this.Floors + "</div><br />" +
                            //                                "</div>";
                            //infowindow.setContent(infoContent);
                            //infowindow.open(map, this);

                            function rad(x) {
                                return x * Math.PI / 180;
                            }
                            var lat = event.latLng.lat();
                            var lng = event.latLng.lng();
                            var R = 6371; // radius of earth in km
                            var distances = [];
                            var closest = -1;
                            for (i = 0; i < markers.length; i++) {
                                if (markers[i].Latitude && markers[i].Latitude > 0 && markers[i].Longitude && markers[i].Longitude > 0) {
                                    var mlat = markers[i].Latitude;
                                    var mlng = markers[i].Longitude;
                                    var dLat = rad(mlat - lat);
                                    var dLong = rad(mlng - lng);
                                    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                                        Math.cos(rad(lat)) * Math.cos(rad(lat)) * Math.sin(dLong / 2) * Math.sin(dLong / 2);
                                    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                                    var d = R * c;
                                    distances[i] = d;
                                    if (closest == -1 || d < distances[closest]) {
                                        closest = i;
                                    }
                                }
                            }
                            var nearbyContent_Point = "";
                            var counter = 0;
                            var distanceObject = [];
                            for (var dst = 0; dst < distances.length; dst++) {
                                if (distances[dst]) {
                                    var obj = {
                                        index: dst,
                                        distance: distances[dst]
                                    };
                                    distanceObject.push(obj);
                                }
                            }
                            distanceObject = distanceObject.sort(function(a, b) {
                                return a.distance - b.distance;
                            });
                            for (var dst = 0; dst < distanceObject.length; dst++) {
                                if (counter < 10) {
                                    counter++;
                                    nearbyContent_Point += "<div id='' style='float:left;'>" +
                                        "<div style='float:left;'><img src='" + markers[distanceObject[dst].index].ImageLink + "' height='100' width='100' /></div>" +
                                        "<div style='padding:2px 0 2px 10px; float:left'>Building: <a href='#' >" + markers[distanceObject[dst].index].Building + " </a></div><br />" +
                                        "<div style='padding:2px 0 2px 10px;float:left'>Price/SqFt: " + markers[distanceObject[dst].index].Price_sqft + "</div><br />" +
                                        "<div style='padding:2px 0 2px 10px;float:left'>Year: " + markers[distanceObject[dst].index].Completion + ". Floors: " + markers[distanceObject[dst].index].Floors + "</div><br />" +
                                        "</div>";
                                } else {
                                    dst = distances.length;
                                }
                            }
                            //nearBy.innerHTML = nearbyContent_Point;
                            //document.getElementById("spanNearbyBuildingName").innerHTML = "Nearby " + this.Building;
                            //this.ImageLink = "http://detroit1701.org/Graphics/Donovan%20Building_Andrew.jpg";
                            document.getElementById("spanNearbyBuildingName").innerHTML = this.Building;
                            nearBy.innerHTML = "<img src='" + this.ImageLink + "' style='width:100%;height: inherit'/>"
                        });
                        google.maps.event.addListener(marker, 'mouseout', function() {
                            this.setIcon("map_images/Circle_Red_Small.png");
                            infowindow_tooltip.close();
                        });
                    }
                }
            }
            setMarkers(map, d);
        })();
        //google.setOnLoadCallback(drawChart, true);
    } else {
        alert("Message: " + o);
    }
}
jQuery(document).ready(
    function() {

    	/*  function getAllAreasSubAreasBuildingsCallback(d, status, o) {
            if (/success/i.test(status) === true) {
                if (d && d.constructor === Array && d.length > 0) {
                  
                    for (var i = 0; i < d.length; i++) {
                        for (var key in d[i]) {
                            if (key !== "Building_Type") {
                                dataForFilters.push(trim(d[i][key]));
                            } else {
                                dataForFilterType.push(trim(d[i][key]));
                            }
                        }
                    }
                    dataForFilters = unique(dataForFilters);
                    dataForFilterType = unique(dataForFilterType);
                    var ulInnerHtml = '',
                        typeInnerHtml = '';
                    for (var j = 0; j < dataForFilters.length; j++) {
                        ulInnerHtml = ulInnerHtml + "<li class='width_175'><a href='#' onclick='bindToTextboxBuilding(\"" + dataForFilters[j] + "\")'>" + dataForFilters[j] + "</a></li>";
                    }
                    for (var jk = 0; jk < dataForFilterType.length; jk++) {
                        typeInnerHtml = typeInnerHtml + "<li><a href='#' onclick='selectedBuildingType(\"" + dataForFilterType[jk] + "\");'>" + dataForFilterType[jk] + "</a></li>";
                    }
                    if (ulInnerHtml.length > 0) {
                        $('#dynamicBuildingLi').append(ulInnerHtml);
                    }
                    if (typeInnerHtml.length > 0) {
                        $('#dynamicBuildingTypeLi').append(typeInnerHtml);
                    }
                } else {
                    alert("Message: " + "Invalid Data");
                }
            } else {
                alert("Message: " + o);
            }
        }
        
        invokeService("ActionServlet", "get", {
                serviceName: "getAllAreasSubAreasBuildings"
            }, getAllAreasSubAreasBuildingsCallback,
            getAllAreasSubAreasBuildingsCallback);*/

        jQuery("#btnSearch").click(function() {
            var input = {
                serviceName: "getSaleAndRentTrendsData",
                building: jQuery("#txtBuilding").val(),
                bedrooms: jQuery("#spanBedrooms").html(),
                minPrice: jQuery("#txtPriceFrom").val(),
                maxPrice: jQuery("#txtPriceTo").val(),
                buildingType: jQuery("#txtBuildingTypes").val()
            }
            var isValid = false;
            for (var key in input) {
                if (input[key].length <= 0) {
                    isValid = false;
                } else {
                    isValid = true;
                }
            }
            if (isValid === true) {
                invokeService("ActionServlet", "get", input, getMapDataCallback, getMapDataCallback);
            } else {
                alert("Please reselect...");
            }
        });
    });