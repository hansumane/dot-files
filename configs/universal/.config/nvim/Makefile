DEPDIR ?= .test-deps
CURL ?= curl -L --create-dirs

NVIM_ARCH ?= linux-x86_64
LUALS_ARCH ?= linux-x64
STYLUA_ARCH ?= linux-x86_64
RUST_ARCH ?= x86_64-unknown-linux-gnu

TSQUERYLS := $(DEPDIR)/ts_query_ls-$(RUST_ARCH)
TSQUERYLS_TARBALL := $(TSQUERYLS).tar.gz
TSQUERYLS_URL := https://github.com/ribru17/ts_query_ls/releases/latest/download/$(notdir $(TSQUERYLS_TARBALL))

.PHONY: query
query: formatquery lintquery checkquery

.PHONY: lintquery
lintquery: $(TSQUERYLS)
	$(TSQUERYLS)/ts_query_ls lint queries

.PHONY: formatquery
formatquery: $(TSQUERYLS)
	$(TSQUERYLS)/ts_query_ls format queries

.PHONY: checkquery
checkquery: $(TSQUERYLS)
	$(TSQUERYLS)/ts_query_ls check queries

$(TSQUERYLS):
	$(CURL) $(TSQUERYLS_URL) -o $(TSQUERYLS_TARBALL)
	mkdir $@
	tar -xf $(TSQUERYLS_TARBALL) -C $@
	rm -rf $(TSQUERYLS_TARBALL)
