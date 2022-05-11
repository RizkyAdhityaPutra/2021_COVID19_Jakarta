library(shiny)
library(shinydashboard)
library(scales)
library(shinyWidgets)

ui <- 
  dashboardPage(
    dashboardHeader(title = "Analisa COVID-19 di Jakarta Tahun 2021"),
    dashboardSidebar(
      sidebarMenu(
        menuItem(text = "Home", tabName = "home", icon = icon("home")),
        menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("chart-line")),
        menuItem(text = "Raw Data", tabName = "raw", icon = icon("file"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "home",
          box(
            width = 12,
            h2("LBB Interactive Plotting\n"),
            h5("by Rizky Adhitya Putra\n"),
            h4("\nDataset ini berisi tentang Rekap Data Bulanan Covid-19 Per Kelurahan Provinsi DKI Jakarta Tahun 2021"),
            h4("\nPenjelasan variabel yang ada pada dataset ini :"),
            h4("\n1. tanggal : Tanggal"),
            h4("\n2. id_kel : ID Kelurahan"),
            h4("\n3. nama_provinsi : Nama Provinsi"),
            h4("\n4. nama_kota : Nama Kota"),
            h4("\n5. nama_kecamatan : Nama Kecamatan"),
            h4("\n6. nama_kelurahan : Nama Kelurahan"),
            h4("\n7. kategori : Kategori pasien Covid - 19"),
            h4("\n8. sub_kategori : Sub Kategori dari kategori awal yang masih terlalu luas menjadi lebih rinci"),
            h4("\n9. jumlah : Jumlah orang"),
            h4("\nData source: https://data.jakarta.go.id/dataset/rekap-data-bulanan-covid-19-per-kelurahan-provinsi-dki-jakarta-tahun-2021")
          )
        ),
        tabItem(
          tabName = "dashboard",
          fluidRow(
            valueBox(
              width = 3,
              value = sum(covid$jumlah),
              subtitle = "Total Jumlah Kasus",
              icon = icon("hospital-user"),
              color = "green"
            ),
            valueBox(
              width = 3,
              value = n_distinct(covid_clean$nama_kota),
              subtitle = "Total Jumlah Kota",
              icon = icon("city"),
              color = "green"
            ),
            valueBox(
              width = 3,
              value = n_distinct(covid_clean$nama_kecamatan),
              subtitle = "Total Jumlah Kecamatan",
              icon = icon("building"),
              color = "green"
            ),
            valueBox(
              width = 3,
              value = n_distinct(covid_clean$nama_kelurahan),
              subtitle = "Total Jumlah Kelurahan",
              icon = icon("building"),
              color = "green"
            ),
            # box(
            #   width = 12,
            #   plotlyOutput(outputId = "plot_trend") 
            # ),
            box(
              width = 5,
              dateRangeInput(
                inputId = "tanggal",
                label = "Silakan masukkan tanggal",
                min = min(covid_clean$tanggal),
                max = max(covid_clean$tanggal),
                start = min(covid_clean$tanggal),
                end = max(covid_clean$tanggal),
                format = "dd-MM-yyyy",
                separator = " sampai dengan "
              )
            ),
            box(
              width = 12,
              plotlyOutput(outputId = "plot_sum_kota")
            ),
            box(
              width = 3,
              numericInput(
                inputId = "topnkec",
                label = "Top N Kecamatan",
                min = 1,
                max = 20,
                value = 10,
                step = 1
              )
            ),
            box(
              width = 4,
              selectInput(
                inputId = "pilih_kota_kec",
                label = "Pilih Kota",
                choices = unique(covid_clean$nama_kota),
                multiple = T,
                selected = "JAKARTA UTARA"
              )
            ),
            box(
              width = 12,
              plotlyOutput(outputId = "plot_sum_kec")
            ),
            box(
              width = 3,
              numericInput(
                inputId = "topnkel",
                label = "Top N Kelurahan",
                min = 1,
                max = 20,
                value = 10,
                step = 1
              )
            ),
            box(
              width = 4,
              selectInput(
                inputId = "pilih_kota_kel",
                label = "Pilih Kota",
                choices = unique(covid_clean$nama_kota),
                multiple = T,
                selected = "JAKARTA UTARA"
              )
            ),
            box(
              width = 12,
              plotlyOutput(outputId = "plot_sum_kel")
            )
          )#tutup fluidRow
        ),#tutup tabItem
        tabItem(
          tabName = "raw",
          fluidPage(
            dataTableOutput("table")
          )
        )
      )#tutup tabItems
    )#tutup dashboardBody
  )#tutup dashboardPage