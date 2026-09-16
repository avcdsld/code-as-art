interface Valentine {
    give(
        chocolate: object,
        love?: any
    ): Promise<{
        sweets: object;
        love: any;
    }> | null | never | void;
}
