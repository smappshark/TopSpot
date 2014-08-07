google.load("visualization", "1", {
    packages: ["corechart"]
});

function drawHistogram(dataArray) {
    function drawChart() {
        var data = google.visualization.arrayToDataTable(dataArray);
        var options = {
            title: 'Resendential Buildings in the Price Ranges(AED)',
            legend: {
                position: 'none'
            },
            colors: ['#00B200'],
			width: 650,
            height: 400,
			backgroundColor: 'transparent'
        };
        var chart = new google.visualization.ColumnChart(document.getElementById('dataContainer'));
        chart.draw(data, options);
    }
    google.setOnLoadCallback(drawChart, true);
}
jQuery(document).ready(function() {
    jQuery(".loader").show();
    jQuery("#dataContainer").hide();

    function createAndReturnElementOption(value, text) {
        var option = document.createElement("option");
        option.setAttribute("value", value);
        option.innerHTML = text;
        return option;
    }

    jQuery.get('ActionServlet', {
        serviceName: "getBedrooms"
    }, function(responseJson) {
        jQuery(".loader").hide();
        if (responseJson && responseJson.constructor === Array) {
            var select = document.getElementById("ddBedrooms");
            if (Object.keys(responseJson).length > 0) {
                select.appendChild(createAndReturnElementOption(-1, "Select Bedrooms"));
                for (var i = 0; i < responseJson.length; i++) {
                    select.appendChild(createAndReturnElementOption(responseJson[i].Bedrooms, responseJson[i].Bedrooms));
                }
            }
        }

    });

    jQuery('select#ddBedrooms').change(function(event) {
        jQuery(".loader").show();
        jQuery("#dataContainer").hide();
        var $bedrooms = jQuery("select#ddBedrooms").val();
        if ($bedrooms != "-1") {
            jQuery.get('ActionServlet', {
                serviceName: "getBedroomHistogram",
                bedrooms: $bedrooms
            }, function(responseJson) {
                jQuery("#dataContainer").show();
                jQuery(".loader").hide();
                if (responseJson && responseJson.constructor === Array && responseJson.length > 0) {
                    var intervals = 20;
                    var minPrice = responseJson[0].Price_AED;
                    var maxPrice = responseJson[responseJson.length - 1].Price_AED;
                    var range = parseInt((maxPrice - minPrice) / intervals, 10);
                    var priceRange = [0, 0],
                        dataArray = [],
                        googleDataArray = [],
                        obj = {};
                    for (var i = 0; i <= responseJson.length; i++) {
                        if (priceRange[1] === 0) {
                            priceRange[1] = parseFloat(responseJson[i].Price_AED) + range;
                        }
                        if (!obj.Range && !obj.Count) {
                            obj = {
                                Count: 0,
                                Range: ""
                            };
                        }
                        if (responseJson[i] && responseJson[i].Price_AED > priceRange[0] && responseJson[i].Price_AED <= priceRange[1]) {
                            obj.Count = obj.Count + responseJson[i].Count;
                            obj.Range = priceRange.join(",");
                        } else {
                            if (obj.Range && obj.Range != "") {
                                dataArray.push(obj);
                            }
                            obj = {
                                Count: 0,
                                Range: ""
                            };
                            if (responseJson[i]) {
                                priceRange[0] = priceRange[1];
                                priceRange[1] = parseFloat(responseJson[i].Price_AED) + range;
                                i--;
                            }
                        }
                    }
                    googleDataArray.push(["Range", "Count", { role: 'annotation' }]);
                    for (var j = 0; j < dataArray.length; j++) {
                        var tmpArray = [];
                        tmpArray.push(dataArray[j].Range);
                        tmpArray.push(dataArray[j].Count);
                        tmpArray.push(dataArray[j].Count);
                        googleDataArray.push(tmpArray);
                    }
                    drawHistogram(googleDataArray);
                }
            });
        }
    });
});