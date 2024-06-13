generate:
	tuist install
	tuist generate

# File Templates 설치 경로 지정
INSTALL_DIR := $(HOME)/Library/Developer/Xcode/Templates/feature.xctemplate

# 파일 목록 지정
FILES := templates/feature.xctemplate/___FILEBASENAME___Feature.swift \
         templates/feature.xctemplate/TemplateIcon-1016.png \
         templates/feature.xctemplate/TemplateInfo.plist

# 템플릿 설치 타겟
templates: $(FILES)
	@echo "Template file들 설치 중 >> $(INSTALL_DIR)"
	@mkdir -p $(INSTALL_DIR)
	@cp -r $(FILES) $(INSTALL_DIR)
	
	
# File Templates 삭제
clean:
	@echo "Template file 삭제...🫧"
	@rm -rf $(INSTALL_DIR)

# Makefile에서 특정 타겟이 실제 파일이나 디렉토리 이름과 상관없음 명시
.PHONY: templates generate clean
