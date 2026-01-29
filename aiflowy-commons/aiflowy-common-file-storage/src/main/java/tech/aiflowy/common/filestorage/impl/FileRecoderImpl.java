package tech.aiflowy.common.filestorage.impl;

import org.dromara.x.file.storage.core.FileInfo;
import org.dromara.x.file.storage.core.recorder.FileRecorder;
import org.dromara.x.file.storage.core.upload.FilePartInfo;
import org.springframework.stereotype.Service;

/**
 * 文件记录器
 */
@Service
public class FileRecoderImpl implements FileRecorder {
    @Override
    public boolean save(FileInfo fileInfo) {
        return true;
    }

    @Override
    public void update(FileInfo fileInfo) {

    }

    @Override
    public FileInfo getByUrl(String url) {
        return null;
    }

    @Override
    public boolean delete(String url) {
        return true;
    }

    @Override
    public void saveFilePart(FilePartInfo filePartInfo) {

    }

    @Override
    public void deleteFilePartByUploadId(String uploadId) {

    }
}
