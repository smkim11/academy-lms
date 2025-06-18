package com.example.academylms.rest;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.academylms.dto.LectureMaterial;
import com.example.academylms.dto.LectureWeek;
import com.example.academylms.service.LectureMaterialService;

@RestController
@RequestMapping("/api/lectureMaterial")
public class LectureMaterialRest {

    @Autowired
    private LectureMaterialService lectureMaterialService;

    // 특정 주차의 강의자료 전체 조회
    @GetMapping("/byWeek")
    public List<LectureMaterial> getMaterialsByWeek(@RequestParam int weekId) {
        return lectureMaterialService.getLectureMaterialsByWeek(weekId);
    }

    // 특정 강의자료 상세 조회
    @GetMapping("/{materialId}")
    public LectureMaterial getMaterial(@PathVariable int materialId) {
        return lectureMaterialService.getLectureMaterialById(materialId);
    }

    // 강의자료 등록
    @PostMapping("/add")
    public String addMaterial(@RequestParam int weekId,
                              @RequestParam("titles") List<String> titles,
                              @RequestParam("files") MultipartFile[] files) throws IOException {

        if (titles == null || titles.isEmpty()) return "제목 누락";
        if (files == null || files.length == 0) return "파일 누락";

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            String title = titles.get(i);

            if (file != null && !file.isEmpty() && title != null && !title.trim().isEmpty()) {
                String uploadDir = "C:/semi";
                String originalFilename = file.getOriginalFilename();
                String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
                File targetFile = new File(uploadDir, savedFilename);
                file.transferTo(targetFile);

                LectureMaterial material = new LectureMaterial();
                material.setWeekId(weekId);
                material.setTitle(title);
                material.setFileUrl("/semi/" + savedFilename);

                lectureMaterialService.addLectureMaterial(material);
            }
        }
        return "자료 업로드 완료";
    }


    // 강의자료 수정
    @PutMapping("/update")
    public String updateMaterial(@RequestParam int materialId,
                                 @RequestParam String title,
                                 @RequestParam(required = false) MultipartFile file) throws IOException {

        if (title == null || title.trim().isEmpty()) return "제목 누락";

        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        if (material == null) return "자료 없음";

        material.setTitle(title);

        if (file != null && !file.isEmpty()) {
            String uploadDir = "C:/semi";
            String originalFilename = file.getOriginalFilename();
            String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
            File targetFile = new File(uploadDir, savedFilename);
            file.transferTo(targetFile);
            material.setFileUrl("/semi/" + savedFilename);
        }

        lectureMaterialService.updateLectureMaterial(material);
        return "수정 완료";
    }
    
    // 강의자료 삭제
    @DeleteMapping("/delete/{materialId}")
    public String deleteMaterial(@PathVariable int materialId) {
        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        if (material == null) return "자료 없음";
        lectureMaterialService.deleteLectureMaterial(materialId);
        return "삭제 완료";
    }

    // 자료가 있는 주차 목록 조회
    @GetMapping("/availableWeeks")
    public List<LectureWeek> getAvailableWeeks(@RequestParam int lectureId) {
        return lectureMaterialService.getWeeksByLectureId(lectureId);
    }
}