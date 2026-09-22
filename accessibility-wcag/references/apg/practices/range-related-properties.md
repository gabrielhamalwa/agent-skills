# Communicating Value and Limits for Range Widgets


## Introduction

ARIA defines the following roles as range widgets, which means they communicate a value that is typically numeric and constrained to defined limits.

- `meter`
- `progressbar`
- `scrollbar`
- `separator` (if focusable)
- `slider`
- `spinbutton`

For example, a spin button for choosing a day within the month of January would allow integer values that range from 1 to 31. In some cases, the value is represented numerically, but is not presented as a number to users. For instance, a spin button for choosing a day of the week could support values from 1 to 7 but they could be presented to the user as day names, e.g., "Monday", "Tuesday", etc.

This section describes considerations for using the following four properties that communicate characteristics of a range widget:

| Property | Definition |
|----|----|
| `aria-valuemin` | Defines the minimum value allowed by a range widget. |
| `aria-valuemax` | Defines the maximum value allowed by a range widget. |
| `aria-valuenow` | Defines the current value of a range widget. This value is a number greater than or equal to `aria-valuemin` and less than or equal to `aria-valuemax` (if they are specified). |
| `aria-valuetext` | If a numeric value is not sufficiently descriptive, this property can define a text description of the current value of a range widget. |



## Using `aria-valuemin`, `aria-valuemax` and `aria-valuenow`

When the value of a range widget is constrained to known limits, the `aria-valuemin` and `aria-valuemax` properties are used to inform assistive technologies of the minimum and maximum values of the range. For some widgets, assistive technologies use this information to present the current value as a percentage. When using these properties, set `aria-valuemin` to the lowest value allowed for the widget and `aria-valuemax` to the highest allowed value. If values for `aria-valuemin` and `aria-valuemax` are not set, default values are exposed to assistive technologies unless the widget is a `spinbutton`, which is the only range widget that does not have default limits.

The `aria-valuenow` property is used to inform assistive technologies of the current value of a range widget. Set `aria-valuenow` to the current value of the widget, ensuring the value of `aria-valuenow` falls within the range defined by `aria-valuemin` and `aria-valuemax`. If the current value of a `progressbar` or `spinbutton` is indeterminate or unknown, omit the `aria-valuenow` property. The `aria-valuenow` property is required for the `meter`, `scrollbar`, `separator` (if the element is focusable), and `slider` roles.

The range widget roles have the following default values and requirements for `aria-valuemin`, `aria-valuemax` and `aria-valuenow`.

<table style="width:100%;">
<colgroup>
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
</colgroup>
<thead>
<tr>
<th scope="col">Role</th>
<th scope="col"><code>aria-valuemin</code><br />
(default)</th>
<th scope="col"><code>aria-valuemax</code><br />
(default)</th>
<th scope="col"><code>aria-valuemin</code><br />
(required)</th>
<th scope="col"><code>aria-valuemax</code><br />
(required)</th>
<th scope="col"><code>aria-valuenow</code><br />
(required)</th>
</tr>
</thead>
<tbody>
<tr>
<th scope="row"><code>meter</code></th>
<td>0</td>
<td>100</td>
<td>No</td>
<td>No</td>
<td>Yes</td>
</tr>
<tr>
<th scope="row"><code>progressbar</code></th>
<td>0</td>
<td>100</td>
<td>No</td>
<td>No</td>
<td>No</td>
</tr>
<tr>
<th scope="row"><code>scrollbar</code></th>
<td>0</td>
<td>100</td>
<td>No</td>
<td>No</td>
<td>Yes</td>
</tr>
<tr>
<th scope="row"><code>separator</code> <span class="small">(if focusable)</span></th>
<td>0</td>
<td>100</td>
<td>No</td>
<td>No</td>
<td>Yes</td>
</tr>
<tr>
<th scope="row"><code>slider</code></th>
<td>0</td>
<td>100</td>
<td>No</td>
<td>No</td>
<td>Yes</td>
</tr>
<tr>
<th scope="row"><code>spinbutton</code></th>
<td>None</td>
<td>None</td>
<td>No</td>
<td>No</td>
<td>No</td>
</tr>
</tbody>
</table>



## Using `aria-valuetext`

When the element's values are contained within a range but those values are not numeric (such as "small", "medium" and "large"), or they are numeric but there is value in communicating more information than just a number, `aria-valuetext` is used to surface the text value to assistive technologies. Only use `aria-valuetext` when `aria-valuenow` is not sufficiently meaningful for users because using `aria-valuetext` will prevent assistive technologies from communicating `aria-valuenow`.


For example, for a battery indicator, it would be useful to know how many minutes are remaining, in addition to the percentage of charge remaining.

    <span id="battery-label">Battery</span>
    <span role="meter" aria-labelledby="battery-label"
      aria-valuenow="5"
      aria-valuetext="5%, 18 minutes remaining.">
    </span>




## Range properties with meter

The `aria-valuemin` and `aria-valuemax` properties only need to be set for elements with role `meter` if the meter's minimum value is not 0 or its maximum value is not 100. It is necessary, however, to always specify a value for `aria-valuenow` and to ensure the value is greater than or equal to the minimum allowed value and less than or equal to the maximum allowed value. A detailed description of the `meter` role is in the [meter pattern](../meter/pattern.md).

This example of a meter shows the current Central Processing Unit (CPU) usage.

    <span id="cpu_usage_label">CPU usage</span>
    <!-- The CPU usage uses the default values of 0 and 100 for aria-valuemin and aria-valuemax -->
    <div role="meter"
      aria-valuenow="90"
      aria-labelledby="cpu_usage_label">
    </div>

The `aria-valuetext` property can be set to a string that makes the meter value understandable. For example, a CPU usage meter value might be conveyed as `aria-valuetext="90% of CPU is being used"`.

Here is another example of a meter that has a range different from the default of 0 for `aria-valuemin` and 100 for `aria-valuemax`.

    <span id="ph_alkaline_meter_label">Alkaline pH(Power of Hydrogen) Level</span>
    <div role="meter"
        aria-valuenow="9"
        aria-valuemin="7"
        aria-valuemax="14"
        aria-labelledby="ph_alkaline_meter_label">
    </div>



## Range properties with progress bars

The `aria-valuemin` and `aria-valuemax` properties only need to be set for the `progressbar` role when the progress bar's minimum is not 0 or the maximum value is not 100. The aria-valuenow property needs to be set for a `progressbar` if its value is known (e.g. not indeterminate). If the `aria-valuenow` property is set, the author needs to make sure it is within the minimum and maximum values.

Following is an example of a progress bar represented by an SVG.

    <div><span id="loadlabel">Loading:</span>
      <!-- The progress bar uses the default values of 0 and 100 for aria-valuemin and aria-valuemax -->
      <span role="progressbar"
            aria-labelledby="loadlabel"
            aria-valuenow="33" >
        <svg width="100" height="10">
          <rect x="0" y="0" height="10" width="100" stroke="black" fill="none"/>
          <rect x="0" y="0" height="10" width="33" fill="green" />
        </svg>
      </span>
    </div>

This progress bar can also be made using the native HTML `progress` element.

    <label for="loadstatus">Loading:</label>
    <progress id="loadstatus" max="100" value="33"></progress>

To represent an indeterminate progress bar where the value range is unknown, omit the `aria-valuenow` attribute.

    <img role="progressbar" src="spinner.gif" alt="Loading...">



## Range properties with scrollbars

The `aria-valuemin` and `aria-valuemax` properties only need to be set for the `scrollbar` role when it's minimum value is not 0 or the maximum value is not 100. The `aria-valuenow` property is required for `scrollbar` and the author needs to make sure it is within the minimum and maximum values.

`aria-valuenow` will generally be exposed as a percentage between `aria-valuemin` and `aria-valuemax` calculated by assistive technologies.

    <span id="pi-label">Pi</div>
    <div id="pi">
    3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
    </div>
    <div class="rail">
    <!-- The scrollbar uses the default values of 0 and 100 for aria-valuemin and aria-valuemax -->
      <div
        class="thumb"
        role="scrollbar"
        aria-labelledby="pi-label"
        aria-controls="pi"
        aria-orientation="horizontal"
        aria-valuenow="25">
      </div>
    </div>



## Range properties with sliders

The `aria-valuemin` and `aria-valuemax` properties only need to be set for the `slider` role when the slider's minimum is not 0 or the maximum value is not 100. The `aria-valuenow` property is required for `slider` role and the author needs to make sure it is within the minimum and maximum values. A detailed description of the `slider` role can be found in the [slider pattern](../slider/pattern.md) and [slider (multi-thumb) pattern](../slider-multithumb/pattern.md).

The following example shows a temperature controller. In this example, `aria-valuenow` is meaningful to the user, and so `aria-valuetext` is not used.

    <div class="rail">
      <div id="thumb" role="slider" aria-valuemin="50" aria-valuenow="68" aria-valuemax="100"
        aria-label="Temperature (F)" tabindex="0">
      </div>
    </div>

The slider example above can be made using the HTML `<input type="range">` element.

    <input type="range" min="50" value="68" max="100" aria-label="Temperature (F)">

The following example is a fan control. The `aria-valuenow` value is "1", which is not meaningful to the user. The `aria-valuetext` property is used so that assistive technology will surface its value ("low") instead.

    <div class="rail">
      <div id="thumb" role="slider" aria-valuemin="0" aria-valuenow="1" aria-valuemax="3"
        aria-valuetext="low" aria-label="Fan speed" tabindex="0" >
      </div>
      <div class="value"> Off </div>
      <div class="value"> Low </div>
      <div class="value"> Medium </div>
      <div class="value"> High </div>
    </div>



## Range properties with spin buttons

The `aria-valuemin` and `aria-valuemax` properties are used only when a `spinbutton` has a defined range. They do not have default values, so if they are not specified, range limits will not be exposed to assistive technologies. Similarly, the `aria-valuenow` property is set only when a `spinbutton` has a value. If it is not set, a value is not exposed to assistive technologies for the `spinbutton`. `aria-valuetext` can be used when appropriate. A detailed description of the `spinbutton` role can be found in the [spinbutton pattern](../spinbutton/pattern.md).

The following example sets the price of paperclips in cents.

    <div role="spinbutton" aria-labelledby="price-label" aria-valuenow="50" tabindex="0">
      <button id="lower-price">Lower</button>
      <button id="raise-price">Raise</button>
      <span id="price-label">Price per paperclip: $</span><span id="price">0.50</span>
    </div>

If there are minimum and maximum allowed values, set the `aria-valuemin` and `aria-valuemax` properties.

    <div role="spinbutton" aria-labelledby="price-label"
      aria-valuemin="1" aria-valuenow="50" aria-valuemax="200" tabindex="0">
      <button id="lower-price">Lower</button>
      <button id="raise-price">Raise</button>
      <span id="price-label">Price per paperclip: $</span><span id="price">0.50</span>
    </div>

The spin button example above can be made using the native HTML `<input type="number">` element.

    <label>Price per paperclip: $<input type="number" min="0.01" value="0.5" max="2" step="0.01"></label>

