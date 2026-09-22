# Grid and Table Properties


## Introduction

To fully present and describe a grid or table, in addition to parsing the headers, rows, and cells using the roles described in the [grid pattern](../grid/pattern.md) or [table pattern](../table/pattern.md), assistive technologies need to be able to determine other structural and presentation characteristics, such as the number and visibility of rows and columns. Characteristics that may need to be described with additional WAI-ARIA attributes include:

- The number of rows and columns.
- Whether any columns or rows are hidden, e.g., columns 1 through 3 and 5 through 8 are visible but column 4 is hidden.
- Whether a cell spans multiple rows or columns.
- Whether and how data is sorted.

Browsers automatically populate their accessibility tree with the number of rows and columns in a grid or table based on the rendered DOM. However, there are many situations where the DOM does not contain the whole grid or table, such as when the data set is too large to fully render. Additionally, some of this information, like skipped columns or rows and how data is sorted, cannot be derived from the DOM structure.

The below sections explain how to use the following properties that ARIA provides for grid and table accessibility.

<table class="widget-features">
<caption>Grid and Table Property Definitions</caption>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th>Property</th>
<th>Definition</th>
</tr>
</thead>
<tbody>
<tr>
<th><code>aria-colcount</code></th>
<td>Defines the total number of columns in a <code>table</code>, <code>grid</code>, or <code>treegrid</code>.</td>
</tr>
<tr>
<th><code>aria-rowcount</code></th>
<td>Defines the total number of rows in a <code>table</code>, <code>grid</code>, or <code>treegrid</code>.</td>
</tr>
<tr>
<th><code>aria-colindex</code></th>
<td><ul>
<li>Defines a cell's position with respect to the total number of columns within a <code>table</code>, <code>grid</code>, or <code>treegrid</code>.</li>
<li><strong>Note:</strong> Numbering starts with 1, not 0.</li>
</ul></td>
</tr>
<tr>
<th><code>aria-rowindex</code></th>
<td><ul>
<li>Defines a cell's position with respect to the total number of rows within a <code>table</code>, <code>grid</code>, or <code>treegrid</code>.</li>
<li><strong>Note:</strong> Numbering starts with 1, not 0.</li>
</ul></td>
</tr>
<tr>
<th><code>aria-colspan</code></th>
<td>Defines the number of columns spanned by a cell or gridcell within a <code>table</code>, <code>grid</code>, or <code>treegrid</code>.</td>
</tr>
<tr>
<th><code>aria-rowspan</code></th>
<td>Defines the number of rows spanned by a cell or gridcell within a <code>table</code>, <code>grid</code>, or <code>treegrid</code>.</td>
</tr>
<tr>
<th><code>aria-sort</code></th>
<td>Indicates if items in a row or column are sorted in ascending or descending order.</td>
</tr>
</tbody>
</table>



## Using `aria-rowcount` and `aria-rowindex`

When the number of rows represented by the DOM structure is not the total number of rows available for a table, grid, or treegrid, the `aria-rowcount` property is used to communicate the total number of rows available, and it is accompanied by the `aria-rowindex` property to identify the row indices of the rows that are present in the DOM.

The `aria-rowcount` is specified on the element with the `table`, `grid`, or `treegrid` role. Its value is an integer equal to the total number of rows available, including header rows. If the total number of rows is unknown, a value of `-1` may be specified. Using a value of `-1` indicates that more rows are available to include in the DOM without specifying the size of the available supply.

When `aria-rowcount` is used on a `table`, `grid`, or `treegrid`, a value for `aria-rowindex` property is specified on each of its descendant rows, including any header rows. The value of `aria-rowindex` is an integer that is:

1.  Greater than or equal to 1.
2.  Greater than the value of `aria-rowindex` on any previous rows.
3.  Set to the index of the first row in the span if cells span multiple rows.
4.  Less than or equal to the total number of rows.

**WARNING!** Missing or inconsistent values of `aria-rowindex` could have devastating effects on assistive technology behavior. For example, specifying an invalid value for `aria-rowindex` or setting it on some but not all rows in a table, could cause screen reader table reading functions to skip rows or simply stop functioning.

The following code demonstrates the use of `aria-rowcount` and `aria-rowindex` properties on a table containing a hypothetical class list.

    <!--
      aria-rowcount tells assistive technologies the actual size of the grid
      is 463 rows even though only 4 rows are present in the markup.
    -->
    <table role="grid" aria-rowcount="463" aria-label="Student roster for history 101">
      <thead>
        <tr aria-rowindex="1">
          <th>Last Name</th>
          <th>First Name</th>
          <th>E-mail</th>
          <th>Major</th>
          <th>Minor</th>
          <th>Standing</th>
        </tr>
      </thead>
      <tbody>
          <!--
            aria-rowindex tells assistive technologies that this
            row is row 51 in the grid of 463 rows.
          -->
        <tr aria-rowindex="51">
          <td>Henderson</td>
          <td>Alan</td>
          <td>ahederson56@myuniveristy.edu</td>
          <td>Business</td>
          <td>Spanish</td>
          <td>Junior</td>
        </tr>
          <!--
            aria-rowindex tells assistive technologies that this
            row is row 52 in the grid of 463 rows.
          -->
        <tr aria-rowindex="52">
          <td>Henderson</td>
          <td>Alice</td>
          <td>ahederson345@myuniveristy.edu</td>
          <td>Engineering</td>
          <td>none</td>
          <td>Sophomore</td>
        </tr>
          <!--
            aria-rowindex tells assistive technologies that this
            row is row 53 in the grid of 463 rows.
          -->
        <tr aria-rowindex="53">
          <td>Henderson</td>
          <td>Andrew</td>
          <td>ahederson75@myuniveristy.edu</td>
          <td>General Studies</td>
          <td>none</td>
          <td>Freshman</td>
        </tr>
      </tbody>
    </table>



## Using `aria-colcount` and `aria-colindex`

When the number of columns represented by the DOM structure is not the total number of columns available for a table, grid, or treegrid, the `aria-colcount` property is used to communicate the total number of columns available, and it is accompanied by the `aria-colindex` property to identify the column indices of the columns that are present in the DOM.

The `aria-colcount` is specified on the element with the `table`, `grid`, or `treegrid` role. Its value is an integer equal to the total number of columns available. If the total number of columns is unknown, a value of `-1` may be specified. Using a value of `-1` indicates that more columns are available to include in the DOM without specifying the size of the available supply.

When `aria-colcount` is used on a `table`, `grid`, or `treegrid`, a value for `aria-colindex` property is either specified on each of its descendant rows or on every cell in each descendant row, depending on whether the columns are contiguous as described below. The value of `aria-colindex` is an integer that is:

1.  Greater than or equal to 1.
2.  When set on a cell, greater than the value set on any previous cell within the same row.
3.  Set to the index of the first column in the span if a cell spans multiple columns.
4.  Less than or equal to the total number of columns.

**WARNING!** Missing or inconsistent values of `aria-colindex` could have devastating effects on assistive technology behavior. For example, specifying an invalid value for `aria-colindex` or setting it on some but not all cells in a row, could cause screen reader table reading functions to skip cells or simply stop functioning.


### Using `aria-colindex` When Column Indices Are Contiguous

When all the cells in a row have column index numbers that are consecutive integers, `aria-colindex` can be set on the row element with a value equal to the index number of the first column in the set. Browsers will then compute a column number for each cell in the row.

The following code shows a grid with 16 columns, of which columns 2 through 5 are displayed to the user. Because the set of columns is contiguous, `aria-colindex` can be placed on each row.

    <div role="grid" aria-colcount="16">
      <div role="rowgroup">
        <div role="row" aria-colindex="2">
          <span role="columnheader">First Name</span>
          <span role="columnheader">Last Name</span>
          <span role="columnheader">Company</span>
          <span role="columnheader">Address</span>
        </div>
      </div>
      <div role="rowgroup">
        <div role="row" aria-colindex="2">
          <span role="gridcell">Fred</span>
          <span role="gridcell">Jackson</span>
          <span role="gridcell">Acme, Inc.</span>
          <span role="gridcell">123 Broad St.</span>
        </div>
        <div role="row" aria-colindex="2">
          <span role="gridcell">Sara</span>
          <span role="gridcell">James</span>
          <span role="gridcell">Acme, Inc.</span>
          <span role="gridcell">123 Broad St.</span>
        </div>
       …
      </div>
    </div>



### Using `aria-colindex` When Column Indices Are Not Contiguous

When the cells in a row have column index numbers that are not consecutive integers, `aria-colindex` needs to be set on each cell in the row. The following example shows a grid for an online grade book where the first two columns contain a student name and subsequent columns contain scores. In this example, the first two columns with the student name are shown, but the score columns have been scrolled to show columns 10 through 13. Columns 3 through 9 are not visible so are not in the DOM.

    <table role="grid" aria-rowcount="463" aria-colcount="13"
      aria-label="Student grades for history 101">
      <!--
        aria-rowcount and aria-colcount tell assistive technologies
        the actual size of the grid is 463 rows by 13 columns,
        which is not the number rows and columns found in the markup.
      -->
      <thead>
        <tr aria-rowindex="1">
          <!--
            aria-colindex tells assistive technologies that the
            following columns represent columns 1 and 2 of the total data set.
          -->
          <th aria-colindex="1">Last Name</th>
          <th aria-colindex="2">First Name</th>
          <!--
            aria-colindex tells users of assistive technologies that the
            following columns represent columns 10, 11, 12, and 13 of
            the overall data set of grades.
          -->
          <th aria-colindex="10">Homework 4</th>
          <th aria-colindex="11">Quiz 2</th>
          <th aria-colindex="12">Homework 5</th>
          <th aria-colindex="13">Homework 6</th>
        </tr>
      </thead>
      <tbody>
        <tr aria-rowindex="50">
          <!--
            every cell needs to define the aria-colindex attribute
          -->
          <td aria-colindex="1">Henderson</td>
          <td aria-colindex="2">Alan</td>
          <td aria-colindex="10">8</td>
          <td aria-colindex="11">25</td>
          <td aria-colindex="12">9</td>
          <td aria-colindex="13">9</td>
        </tr>
        <tr aria-rowindex="51">
          <td aria-colindex="1">Henderson</td>
          <td aria-colindex="2">Alice</td>
          <td aria-colindex="10">10</td>
          <td aria-colindex="11">27</td>
          <td aria-colindex="12">10</td>
          <td aria-colindex="13">8</td>
        </tr>
        <tr aria-rowindex="52">
          <td aria-colindex="1">Henderson</td>
          <td aria-colindex="2">Andrew</td>
          <td aria-colindex="10">9</td>
          <td aria-colindex="11">0</td>
          <td aria-colindex="12">29</td>
          <td aria-colindex="13">8</td>
        </tr>
      </tbody>
    </table>




## Defining cell spans using `aria-colspan` and `aria-rowspan`

For tables, grids, and treegrids created using elements other than HTML `table` elements, row and column spans are defined with the `aria-rowspan` and `aria-colspan` properties.

The value of `aria-colspan` is an integer that is:

1.  Greater than or equal to 1.
2.  less than the value that would cause the cell to overlap the next cell in the same row.

The value of `aria-rowspan` is an integer that is:

1.  Greater than or equal to 0.
2.  0 means the cell spans all the remaining rows in its row group.
3.  less than the value that would cause the cell to overlap the next cell in the same column.

The following example grid has a two row header. The first two columns have headers that span both rows of the header. The subsequent 6 columns are grouped into 3 pairs with headers in the first row that each span two columns.

    <div role="grid" aria-rowcount="463"
      aria-label="Student grades for history 101">
      <div role="rowgroup">
        <div role="row" aria-rowindex="1">
            <!--
              aria-rowspan and aria-colspan provide
              assistive technologies with the correct data cell header information
              when header cells span more than one row or column.
            -->
            <span role="columnheader" aria-rowspan="2">Last Name</span>
            <span role="columnheader" aria-rowspan="2">First Name</span>
            <span role="columnheader" aria-colspan="2">Test 1</span>
            <span role="columnheader" aria-colspan="2">Test 2</span>
            <span role="columnheader" aria-colspan="2">Final</span>
        </div>
        <div role="row" aria-rowindex="2">
            <span role="columnheader">Score</span>
            <span role="columnheader">Grade</span>
            <span role="columnheader">Score</span>
            <span role="columnheader">Grade</span>
            <span role="columnheader">Total</span>
            <span role="columnheader">Grade</span>
        </div>
      </div>
      <div role="rowgroup">
        <div role="row" aria-rowindex="50">
          <span role="cell">Henderson</span>
          <span role="cell">Alan</span>
          <span role="cell">89</span>
          <span role="cell">B+</span>
          <span role="cell">72</span>
          <span role="cell">C</span>
          <span role="cell">161</span>
          <span role="cell">B-</span>
        </div>
        <div role="row" aria-rowindex="51">
          <span role="cell">Henderson</span>
          <span role="cell">Alice</span>
          <span role="cell">94</span>
          <span role="cell">A</span>
          <span role="cell">86</span>
          <span role="cell">B</span>
          <span role="cell">180</span>
          <span role="cell">A-</span>
        </div>
        <div role="row" aria-rowindex="52">
          <span role="cell">Henderson</span>
          <span role="cell">Andrew</span>
          <span role="cell">82</span>
          <span role="cell">B-</span>
          <span role="cell">95</span>
          <span role="cell">A</span>
          <span role="cell">177</span>
          <span role="cell">B+</span>
        </div>
      </div>
    </div>

**Note:** When using HTML `table` elements, use the native semantics of the `th` and `td` elements to define row and column spans by using the `rowspan` and `colspan` attributes.



## Indicating sort order with `aria-sort`

When rows or columns are sorted, the `aria-sort` property can be applied to a column or row header to indicate the sorting method. The following table describes allowed values for `aria-sort`.

| Value | Description |
|----|----|
| `ascending` | Data are sorted in ascending order. |
| `descending` | Data are sorted in descending order. |
| `other` | Data are sorted by an algorithm other than ascending or descending. |
| `none` | Default (no sort applied). |

Description of values for `aria-sort` {.widget-features}

It is important to note that ARIA does not provide a way to indicate levels of sort for data sets that have multiple sort keys. Thus, there is limited value to applying `aria-sort` with a value other than `none` to more than one column or row.

The following example grid uses `aria-sort` to indicate the rows are sorted from the highest "Quiz 2" score to the lowest "Quiz 2" score.

    <table role="grid" aria-rowcount="463" aria-colcount="13"
      aria-label="Student grades for history 101">
      <thead>
        <tr aria-colindex="10" aria-rowindex="1">
          <th>Homework 4</th>
          <!--
            aria-sort indicates the column with the heading
            "Quiz 2" has been used to sort the rows of the grid.
          -->
          <th aria-sort="descending">Quiz 2</th>
          <th>Homework 5</th>
          <th>Homework 6</th>
        </tr>
      </thead>
      <tbody>
        <tr aria-colindex="10" aria-rowindex="50">
          <td>8</td>
          <td>30</td>
          <td>9</td>
          <td>9</td>
        </tr>
        <tr aria-colindex="10"  aria-rowindex="51">
          <td>10</td>
          <td>29</td>
          <td>10</td>
          <td>8</td>
        </tr>
        <tr aria-colindex="10"  aria-rowindex="52">
          <td>9</td>
          <td>9</td>
          <td>27</td>
          <td>6</td>
        </tr>
        <tr aria-colindex="10"  aria-rowindex="53">
          <td>9</td>
          <td>10</td>
          <td>26</td>
          <td>8</td>
        </tr>
        <tr aria-colindex="10"  aria-rowindex="54">
          <td>9</td>
          <td>7</td>
          <td>24</td>
          <td>6</td>
        </tr>
      </tbody>
    </table>

