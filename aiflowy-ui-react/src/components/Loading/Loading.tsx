// components/Loading.tsx
import React from "react";
import styles from "../../pages/commons/login.module.less";

const Loading: React.FC = () => {
    return (
        <div className={styles.loadingContainer}>
            <div className={styles.spinner}></div>
            <p>加载中...</p>
        </div>
    );
};

export default Loading;