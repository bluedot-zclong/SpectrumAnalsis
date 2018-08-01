package bluedot.spectrum.common;

public enum Singleton {
    INSTANCE,STANDARD;
    private SpectrumResultSet instance;
    private StandardSpectrum standard;
    Singleton() {
        instance = new SpectrumResultSet();
        standard = new StandardSpectrum();
    }
    public SpectrumResultSet getInstance() {
        return instance;
    }
    public StandardSpectrum StandardSpectrum() {
        return standard;
    }
}