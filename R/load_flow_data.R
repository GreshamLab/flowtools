load_flow_data <- function(dir = ".",
                           files = sort(list.files(path=dir,pattern = ".fcs", full.names=TRUE)),
                           sample_sheet = "sample_sheet.csv",
                           sample_sheet_format = "csv",
                           sample_names = "Strain") {

  #read all the .fcs files in
  flow_data <- read.ncdfFlowSet(files=files, pattern=".fcs", alter.names = TRUE)

  #function to read sample sheet depends on format.  Both scenarios result in a tibble
  if(sample_sheet_format == "csv") {
    print("using csv sample sheet")
    sample_sheet <- read_csv(paste(path=dir,sample_sheet, sep="/"))
      }
  else if(sample_sheet_format == "excel") {
    print("using excel sample sheet")
    sample_sheet <- read_excel(paste(path=dir,sample_sheet, sep="/"))
  }

  #assign the sample names from the appropriate column of the sample sheet

  if(sample_names == "Sample"){
  sampleNames(flow_data) <- paste(gsub(" ","_",sample_sheet$Sample),"  ",sub(" ","_",sample_sheet$Well), sep="")
  }
  else if(sample_names == "Strain"){
    sampleNames(flow_data) <- paste(gsub(" ","_",sample_sheet$Strain),"  ",sub(" ","_",sample_sheet$Well), sep="")
  }

  return(flow_data)
}
