

testcmd <- readLines("https://raw.githubusercontent.com/macs3-project/MACS/master/test/cmdlinetest")
f1 <- sub(".*=", "", grep("^CHIP", testcmd, value = TRUE))
f2 <- sub(".*=", "", grep("^CTRL", testcmd, value = TRUE))
fs <- c(f1, f2)
type <- rep("BED", length(fs))
type[grep(".bam", fs)] <- "BAM"
cbase <- rep(FALSE, length(fs))
cbase[type == "BAM"] <- TRUE

meta_data <- data.frame(
    Title = rep("MACS test datasets", 9),
    Description = sub(".bed.gz|.bedpe.gz|.bam", "", fs),
    BiocVersion = "3.12",
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
meta_data[meta_data$Description == "contigs50k", c("Genome", "Species", "TaxonomyId")] <- NA

write.csv(meta_data, file = "metadata.csv", row.names = FALSE)
