#' gtexr arguments
#'
#' Internal function that documents all arguments for exported gtexr functions
#' that wrap GTEx Portal API endpoints (using roxygen `@inheritParams` tag).
#' @param ageBrackets The age bracket(s) of the donors of interest. Options:
#'   "20-29", "30-39", "40-49", "50-59", "60-69", "70-79".
#' @param aliquotIds Character vector.
#' @param autolysisScores Character vector. Options: "None", "Mild", "Moderate",
#'   "Severe".
#' @param attributeSubset String. Examples include but are not limited to "sex", "ageBracket"
#' @param bp_window Integer.
#' @param cellType String. "Adipocytes", "Epithelial_cells", "Hepatocytes",
#'   "Keratinocytes", "Myocytes", "Neurons", "Neutrophils".
#' @param chromosome String. One of "chr1", "chr2", "chr3", "chr4", "chr5",
#'   "chr6", "chr7", "chr8", "chr9", "chr10", "chr11", "chr12", "chr13",
#'   "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21",
#'   "chr22", "chrM", "chrX", "chrY".
#' @param datasetId String. Unique identifier of a dataset. Usually includes a
#'   data source and data release. Options: "gtex_v8", "gtex_snrnaseq_pilot".
#' @param dataTypes Character vector. Options: "RNASEQ", "WGS", "WES", "OMNI",
#'   "EXCLUDE".
#' @param draw Integer.
#' @param end Integer.
#' @param excludeDataArray String. Options are TRUE or FALSE
#' @param .featureId String. A genomic feature e.g. GENCODE ID, RSID or
#' GTEx Variant ID.
#' @param filterMtGene Logical. Exclude mitochondrial genes.
#' @param gencodeId String. A Versioned GENCODE ID of a gene, e.g.
#'   "ENSG00000065613.9".
#' @param gencodeIds A character vector of Versioned GENCODE IDs, e.g.
#'   c("ENSG00000132693.12", "ENSG00000203782.5").
#' @param gencodeVersion String (default = "v26"). GENCODE annotation release.
#'   Either "v26" or "v19".
#' @param geneId String. A gene symbol, a gencode ID, or an Ensemble ID.
#' @param geneIds A character vector of gene symbols, versioned gencodeIds, or
#'   unversioned gencodeIds.
#' @param genomeBuild String. Options: "GRCh38/hg38", "GRCh37/hg19". Default =
#'   "GRCh38/hg38".
#' @param hardyScale String A Hardy Scale of interest.
#'   Options: "Ventilator case", "Fast death - violent", "Fast death - natural
#'   causes", "Intermediate death", "Slow death".
#' @param hardyScales Character vector. A list of Hardy Scale(s) of interest.
#'   Options: "Ventilator case", "Fast death - violent", "Fast death - natural
#'   causes", "Intermediate death", "Slow death".
#' @param hasExpressionData Logical.
#' @param hasGenotype Logical.
#' @param itemsPerPage Integer (default = 250). Set globally to maximum value
#'   100000 with `options(list(gtexr.itemsPerPage = 100000))`.
#' @param ischemicTimes Integer.
#' @param ischemicTimeGroups Character vector. Options:
#'   "<= 0", "1 - 300", "301 - 600", "601 - 900", "901 - 1200", "1201 - 1500", "> 1500".
#' @param materialTypes String, vector. Options: "Cells:Cell Line Viable",
#'   "DNA:DNA Genomic", "DNA:DNA Somatic", "RNA:Total RNA", "Tissue:PAXgene
#'   Preserved", "Tissue:PAXgene Preserved Paraffin-embedded", "Tissue:Fresh
#'   Frozen Tissue".
#' @param organizationName String. Options: "GTEx Consortium" "Kid's First".
#' @param page Integer (default = 0).
#' @param pathCategory Character vector. Options: "adenoma", "amylacea",
#'   "atelectasis", "atherosclerosis", "atherosis", "atrophy", "calcification",
#'   "cirrhosis", "clean_specimens", "congestion", "corpora_albicantia", "cyst",
#'   "desquamation", "diabetic", "dysplasia", "edema", "emphysema",
#'   "esophagitis", "fibrosis", "gastritis", "glomerulosclerosis", "goiter",
#'   "gynecomastoid", "hashimoto", "heart_failure_cells", "hemorrhage",
#'   "hepatitis", "hyalinization", "hypereosinophilia", "hyperplasia",
#'   "hypertrophy", "hypoxic", "infarction", "inflammation", "ischemic_changes",
#'   "macrophages", "mastopathy", "metaplasia", "monckeberg", "necrosis",
#'   "nephritis", "nephrosclerosis", "no_abnormalities", "nodularity",
#'   "pancreatitis", "pigment", "pneumonia", "post_menopausal", "prostatitis",
#'   "saponification", "scarring", "sclerotic", "solar_elastosis",
#'   "spermatogenesis", "steatosis", "sweat_glands", "tma".
#' @param phenotypeId String. See
#'   [GTEx portal FAQs](https://www.gtexportal.org/home/faq#splicingPhenotypeId)
#'   for further details.
#' @param pos Integer.
#' @param poss Integer, vector.
#' @param project_id String. Options: "gtex", "adult-gtex", "egtex".
#' @param .return_raw Logical. If `TRUE`, return the raw API JSON response.
#'   Default = `FALSE`
#' @param rins Integer, vector.
#' @param sampleId String. `^GTEX-[A-Z0-9]{5}-[0-9]{4}-SM-[A-Z0-9]{5}$`
#' @param sampleIds Character vector. GTEx sample ID.
#' @param searchTerm String.
#' @param sex String. Options: "male", "female".
#' @param snpId String
#' @param sortBy String. Options: "sampleId", "ischemicTime", "aliquotId",
#'   "tissueSampleId", "hardyScale", "pathologyNotes", "ageBracket",
#'   "tissueSiteDetailId", "sex".
#' @param sortDirection String. Options: "asc", "desc". Default = "asc".
#' @param start Integer.
#' @param subjectIds Character vector. GTEx subject ID.
#' @param tissueSampleIds Array of strings. A list of Tissue Sample ID(s).
#' @param tissueSiteDetailId String. The ID of the tissue of interest. Can be a
#'   GTEx specific ID (e.g. "Whole_Blood"; use [get_tissue_site_detail()]
#'   to see valid values) or an Ontology ID.
#' @param tissueSiteDetailIds Character vector of IDs for tissues of interest.
#'   Can be GTEx specific IDs (e.g. "Whole_Blood"; use
#'   [get_tissue_site_detail()] to see valid values) or Ontology IDs.
#' @param uberonIds Character vector of Uberon IDs (e.g. "UBERON:EFO_0000572";
#'   use [get_tissue_site_detail()] to see valid values).
#' @param variantId String. A gtex variant ID.
#' @param variantIds Character vector. Gtex variant IDs.
#' @param .verbose Logical. If `TRUE` (default), print paging information. Set
#'   to `FALSE` globally with `options(list(gtexr.verbose = FALSE))`.
#'
#' @keywords internal
#' @returns A tibble of gtexr arguments and their metadata. Used for
#'   documentation only.
gtexr_arguments <- function(ageBrackets = NULL,
                            aliquotIds = NULL,
                            attributeSubset = NULL,
                            autolysisScores = NULL,
                            cellType = NULL,
                            bp_window = NULL,
                            chromosome = NULL,
                            datasetId = NULL,
                            dataTypes = NULL,
                            draw = NULL,
                            end = NULL,
                            excludeDataArray = NULL,
                            .featureId = NULL,
                            filterMtGene = NULL,
                            gencodeId = NULL,
                            gencodeIds = NULL,
                            gencodeVersion = NULL,
                            geneId = NULL,
                            geneIds = NULL,
                            genomeBuild = NULL,
                            hardyScale = NULL,
                            hardyScales = NULL,
                            hasExpressionData = NULL,
                            hasGenotype = NULL,
                            itemsPerPage = NULL,
                            ischemicTimes = NULL,
                            ischemicTimeGroups = NULL,
                            materialTypes = NULL,
                            organizationName = NULL,
                            page = NULL,
                            pathCategory = NULL,
                            phenotypeId = NULL,
                            pos = NULL,
                            poss = NULL,
                            project_id = NULL,
                            .return_raw = NULL,
                            rins = NULL,
                            sampleId = NULL,
                            sampleIds = NULL,
                            searchTerm = NULL,
                            sex = NULL,
                            snpId = NULL,
                            sortBy = NULL,
                            sortDirection = NULL,
                            start = NULL,
                            subjectIds = NULL,
                            tissueSampleIds = NULL,
                            tissueSiteDetailId = NULL,
                            tissueSiteDetailIds = NULL,
                            uberonIds = NULL,
                            variantId = NULL,
                            variantIds = NULL,
                            .verbose = NULL) {
  tibble::tribble(
    ~arg, ~type, ~scalar, ~pluralised, ~shinyinput, ~choices,
    "ageBrackets", "character", FALSE, TRUE, "selectInput", c("20-29", "30-39", "40-49", "50-59", "60-69", "70-79"),
    "aliquotIds", "character", FALSE, TRUE, "textAreaInput", NA,
    "attributeSubset", "character", TRUE, FALSE, "selectInput", c("sex", "ageBracket"),
    "autolysisScores", "character", FALSE, TRUE, "selectInput", c("None", "Mild", "Moderate", "Severe"),
    "cellType", "character", TRUE, FALSE, "selectInput", c("Adipocytes", "Epithelial_cells", "Hepatocytes", "Keratinocytes", "Myocytes", "Neurons", "Neutrophils"),
    "bp_window", "integer", TRUE, FALSE, "numericInput", c(0, 248936581),
    "chromosome", "character", TRUE, FALSE, "selectInput", c(paste0("chr", 1:22), paste0("chr", c("M", "X", "Y"))),
    "datasetId", "character", TRUE, FALSE, "selectInput", c("gtex_v8", "gtex_snrnaseq_pilot"),
    "dataTypes", "character", FALSE, TRUE, "selectInput", c("RNASEQ", "WGS", "WES", "OMNI", "EXCLUDE"),
    "draw", "integer", TRUE, FALSE, "numericInput", c(0, 250000000),
    "end", "integer", TRUE, FALSE, "numericInput", c(0, 250000000),
    "excludeDataArray", "logical", TRUE, FALSE, "checkboxInput", NA,
    ".featureId", "character", TRUE, FALSE, "textInput", NA,
    "filterMtGene", "logical", TRUE, FALSE, "checkboxInput", NA,
    "gencodeId", "character", TRUE, FALSE, "textInput", NA,
    "gencodeIds", "character", FALSE, TRUE, "textAreaInput", NA,
    "gencodeVersion", "character", TRUE, FALSE, "selectInput", c("v26", "v19"),
    "geneId", "character", TRUE, FALSE, "textInput", NA,
    "geneIds", "character", FALSE, TRUE, "textAreaInput", NA,
    "genomeBuild", "character", TRUE, FALSE, "selectInput", c("GRCh38/hg38", "GRCh37/hg19"),
    "hardyScale", "character", TRUE, FALSE, "selectInput", c("Ventilator case", "Fast death - violent", "Fast death - natural causes", "Intermediate death", "Slow death"),
    "hardyScales", "character", FALSE, TRUE, "selectizeInput", c("Ventilator case", "Fast death - violent", "Fast death - natural causes", "Intermediate death", "Slow death"),
    "hasExpressionData", "logical", TRUE, FALSE, "checkboxInput", NA,
    "hasGenotype", "logical", TRUE, FALSE, "checkboxInput", NA,
    "itemsPerPage", "integer", TRUE, FALSE, "numericInput", c(0, 100000),
    "ischemicTimes", "integer", FALSE, TRUE, "numericInput", c(-1300, 2100),
    "ischemicTimeGroups", "character", FALSE, TRUE, "selectInput", c("<= 0", "1 - 300", "301 - 600", "601 - 900", "901 - 1200", "1201 - 1500", "> 1500"),
    "materialTypes", "character", FALSE, TRUE, "selectizeInput", c("Cells:Cell Line Viable", "DNA:DNA Genomic", "DNA:DNA Somatic", "RNA:Total RNA", "Tissue:PAXgene Preserved", "Tissue:PAXgene Preserved Paraffin-embedded", "Tissue:Fresh Frozen Tissue"),
    "organizationName", "character", TRUE, FALSE, "selectInput", c("GTEx Consortium", "Kid's First"),
    "page", "integer", TRUE, FALSE, "numericInput", c(0, 1000000),
    "pathCategory", "character", FALSE, FALSE, "selectizeInput", c("adenoma", "amylacea", "atelectasis", "atherosclerosis", "atherosis", "atrophy", "calcification", "cirrhosis", "clean_specimens", "congestion", "corpora_albicantia", "cyst", "desquamation", "diabetic", "dysplasia", "edema", "emphysema", "esophagitis", "fibrosis", "gastritis", "glomerulosclerosis", "goiter", "gynecomastoid", "hashimoto", "heart_failure_cells", "hemorrhage", "hepatitis", "hyalinization", "hypereosinophilia", "hyperplasia", "hypertrophy", "hypoxic", "infarction", "inflammation", "ischemic_changes", "macrophages", "mastopathy", "metaplasia", "monckeberg", "necrosis", "nephritis", "nephrosclerosis", "no_abnormalities", "nodularity", "pancreatitis", "pigment", "pneumonia", "post_menopausal", "prostatitis", "saponification", "scarring", "sclerotic", "solar_elastosis", "spermatogenesis", "steatosis", "sweat_glands", "tma"),
    "phenotypeId", "character", TRUE, FALSE, "textInput", NA,
    "pos", "integer", TRUE, FALSE, "numericInput", c(0, 248945542),
    "poss", "integer", FALSE, TRUE, "numericInput", c(0, 248945542),
    "project_id", "character", TRUE, FALSE, "selectInput", c("gtex", "adult-gtex", "egtex"),
    "rins", "numeric", FALSE, TRUE, "numericInput", c(-1e8L, 1e8L),
    "sampleId", "character", TRUE, FALSE, "textInput", NA,
    "sampleIds", "character", FALSE, TRUE, "textAreaInput", NA,
    "searchTerm", "character", TRUE, FALSE, "textInput", NA,
    "sex", "character", TRUE, FALSE, "selectInput", c("male", "female"),
    "snpId", "character", TRUE, FALSE, "textInput", NA,
    "sortBy", "character", TRUE, FALSE, "selectInput", c("sampleId", "ischemicTime", "aliquotId", "tissueSampleId", "hardyScale", "pathologyNotes", "ageBracket", "tissueSiteDetailId", "sex"),
    "sortDirection", "character", TRUE, FALSE, "selectInput", c("asc", "desc"),
    "start", "integer", TRUE, FALSE, "numericInput", c(0, 250000000),
    "subjectIds", "character", TRUE, TRUE, "textAreaInput", NA,
    "tissueSampleIds", "character", FALSE, TRUE, "textAreaInput", NA,
    "tissueSiteDetailId", "character", TRUE, FALSE, "selectInput", c("Adipose_Subcutaneous", "Adipose_Visceral_Omentum", "Adrenal_Gland", "Artery_Aorta", "Artery_Coronary", "Artery_Tibial", "Bladder", "Brain_Amygdala", "Brain_Anterior_cingulate_cortex_BA24", "Brain_Caudate_basal_ganglia", "Brain_Cerebellar_Hemisphere", "Brain_Cerebellum", "Brain_Cortex", "Brain_Frontal_Cortex_BA9", "Brain_Hippocampus", "Brain_Hypothalamus", "Brain_Nucleus_accumbens_basal_ganglia", "Brain_Putamen_basal_ganglia", "Brain_Spinal_cord_cervical_c-1", "Brain_Substantia_nigra", "Breast_Mammary_Tissue", "Cells_EBV-transformed_lymphocytes", "Cells_Cultured_fibroblasts", "Cervix_Ectocervix", "Cervix_Endocervix", "Colon_Sigmoid", "Colon_Transverse", "Esophagus_Gastroesophageal_Junction", "Esophagus_Mucosa", "Esophagus_Muscularis", "Fallopian_Tube", "Heart_Atrial_Appendage", "Heart_Left_Ventricle", "Kidney_Cortex", "Kidney_Medulla", "Liver", "Lung", "Minor_Salivary_Gland", "Muscle_Skeletal", "Nerve_Tibial", "Ovary", "Pancreas", "Pituitary", "Prostate", "Skin_Not_Sun_Exposed_Suprapubic", "Skin_Sun_Exposed_Lower_leg", "Small_Intestine_Terminal_Ileum", "Spleen", "Stomach", "Testis", "Thyroid", "Uterus", "Vagina", "Whole_Blood"),
    "tissueSiteDetailIds", "character", FALSE, TRUE, "selectizeInput", c("Adipose_Subcutaneous", "Adipose_Visceral_Omentum", "Adrenal_Gland", "Artery_Aorta", "Artery_Coronary", "Artery_Tibial", "Bladder", "Brain_Amygdala", "Brain_Anterior_cingulate_cortex_BA24", "Brain_Caudate_basal_ganglia", "Brain_Cerebellar_Hemisphere", "Brain_Cerebellum", "Brain_Cortex", "Brain_Frontal_Cortex_BA9", "Brain_Hippocampus", "Brain_Hypothalamus", "Brain_Nucleus_accumbens_basal_ganglia", "Brain_Putamen_basal_ganglia", "Brain_Spinal_cord_cervical_c-1", "Brain_Substantia_nigra", "Breast_Mammary_Tissue", "Cells_EBV-transformed_lymphocytes", "Cells_Cultured_fibroblasts", "Cervix_Ectocervix", "Cervix_Endocervix", "Colon_Sigmoid", "Colon_Transverse", "Esophagus_Gastroesophageal_Junction", "Esophagus_Mucosa", "Esophagus_Muscularis", "Fallopian_Tube", "Heart_Atrial_Appendage", "Heart_Left_Ventricle", "Kidney_Cortex", "Kidney_Medulla", "Liver", "Lung", "Minor_Salivary_Gland", "Muscle_Skeletal", "Nerve_Tibial", "Ovary", "Pancreas", "Pituitary", "Prostate", "Skin_Not_Sun_Exposed_Suprapubic", "Skin_Sun_Exposed_Lower_leg", "Small_Intestine_Terminal_Ileum", "Spleen", "Stomach", "Testis", "Thyroid", "Uterus", "Vagina", "Whole_Blood"),
    "uberonIds", "character", FALSE, TRUE, "selectizeInput", c("UBERON:EFO_0000572", "UBERON:EFO_0002009", "UBERON:0000007", "UBERON:0000458", "UBERON:0000473", "UBERON:0000945", "UBERON:0000992", "UBERON:0000995", "UBERON:0000996", "UBERON:0001114", "UBERON:0001150", "UBERON:0001157", "UBERON:0001159", "UBERON:0001211", "UBERON:0001225", "UBERON:0001255", "UBERON:0001293", "UBERON:0001323", "UBERON:0001496", "UBERON:0001621", "UBERON:0001870", "UBERON:0001873", "UBERON:0001874", "UBERON:0001876", "UBERON:0001882", "UBERON:0001898", "UBERON:0001954", "UBERON:0002037", "UBERON:0002038", "UBERON:0002046", "UBERON:0002106", "UBERON:0002190", "UBERON:0002367", "UBERON:0002369", "UBERON:0003889", "UBERON:0004264", "UBERON:0004550", "UBERON:0004648", "UBERON:0006330", "UBERON:0006469", "UBERON:0006566", "UBERON:0006631", "UBERON:0006920", "UBERON:0007610", "UBERON:0008367", "UBERON:0008952", "UBERON:0009834", "UBERON:0009835", "UBERON:0010414", "UBERON:0011907", "UBERON:0012249", "UBERON:0013756", "UBERON:0036149"),
    "variantId", "character", TRUE, FALSE, "textInput", NA,
    "variantIds", "character", FALSE, TRUE, "textAreaInput", NA
  )
}
