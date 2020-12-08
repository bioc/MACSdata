
testcmd <- readLines("https://raw.githubusercontent.com/macs3-project/MACS/master/test/cmdlinetest")
f1 <- sub(".*=", "", grep("^CHIP", testcmd, value = TRUE))
f2 <- sub(".*=", "", grep("^CTRL", testcmd, value = TRUE))
fs <- c(f1, f2)
fs[fs == "input_12878_5M.bed.gz"] <- "Input_12878_5M.bed.gz"
type <- rep("BED", length(fs))
type[grep(".bam", fs)] <- "BAM"
cbase <- rep(FALSE, length(fs))
cbase[type == "BAM"] <- TRUE

meta_data <- data.frame(
    Title = fs,
    Description = c("CTCF single end bed file",
                    "CTCF pair end bam file",
                    "CTCF pair end bed file",
                    "simulated contigs 50k bed file",
                    "CTCF 12878 bed file",
                    "CTCF single end control bed file",
                    "CTCF pair end control bam file",
                    "CTCF pair end control bed file",
                    "CTCF 12878 control bed file"),
    BiocVersion = "3.13",
    Genome = "GRCh37",
    SourceType= type,
    SourceUrl = "https://github.com/macs3-project/MACS/tree/master/test",
    SourceVersion = "v1",
    Species = "Home sapiens",
    TaxonomyId="9606",
    Coordinate_1_based = cbase,
    DataProvider = "MACS",
    Maintainer = "Qiang Hu <qiang.hu@roswellpark.org>",
    RDataClass="character",
    DispatchClass="FilePath",
    RDataPath = file.path("MACSdata", fs),
    stringsAsFactors = FALSE
)
meta_data[meta_data$Title == "contigs50k.bed.gz", c("Genome", "Species", "TaxonomyId")] <- NA

write.csv(meta_data, file = "metadata.csv", row.names = FALSE)
