package com.aokle.util;

import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.image.codec.jpeg.JPEGCodec;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.awt.image.AffineTransformOp;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.io.*;

/**
 * 仅仅处理jpg,gif,png,bmp的图片
 * 
 * @author qinyongcai
 */
public class ImageZoom {
	/**
	 * 功能：图片缩放
	 * 
	 * @param realPath
	 *            应用的路径 最后要有 / 最终的组合方式：realPath+imageSource 就算realPath==""
	 *            也不会影响使用
	 * @param imageSource
	 *            源图片
	 * @param imageTarget
	 *            目标图片
	 * @param targetWidth
	 *            最大宽
	 * @param targetHeight
	 *            最大高
	 * @param opType
	 *            1=缩放gif格式的图片 2=gif格式的图片不缩放
	 * @param zoomType
	 *            opType优先 1=对宽或高超出预定的进行原图比例等比例的缩放 2=对宽或高超出预定的进行给定比例等比例的缩放
	 *            3=对不符合预定比例的进行原图比例缩放 4=对不符合预定比例的进行给定比例缩放
	 * @return 1=成功
	 */
	public int zoom(String imageSource, String imageTarget, int targetWidth,
			int targetHeight, int opType, int zoomType) throws Exception {
		int result = 0;
		// targetWidth，targetHeight分别表示目标长和宽
		double ratio = 1.0d;
		double ratio_ts_w = 1.0d;
		double ratio_ts_h = 1.0d;

		BufferedImage imageSourceBF = null;
		BufferedImage imageTargetBF = null;
		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		AffineTransformOp atfop = null;
		Image Itemp = null;
		Graphics g = null;

		FileUtil fileUtil = new FileUtil();
		String imageSourceExt = FileUtil.getFileExt(imageSource);
		if (imageSourceExt == null) {
			imageSourceExt = "";
		}
		imageSourceExt = imageSourceExt.toLowerCase();
		if ("".equals(imageSourceExt)
				|| (!"jpg".equals(imageSourceExt)
						&& !"gif".equals(imageSourceExt)
						&& !"png".equals(imageSourceExt) && !"bmp"
						.equals(imageSourceExt))) {// 扩展名不是图片文件

			throw new Exception("imageSource isn't image! imageSource="
					+ imageSource);
		}

		File imageSourceFile = new File(imageSource);
		if (!imageSourceFile.exists() || !imageSourceFile.isFile()) {
			throw new Exception("imageSource isn't exist! imageSource="
					+ imageSource);
		}

		String imageTargetExt = FileUtil.getFileExt(imageTarget);
		if (imageTargetExt == null) {
			imageTargetExt = "";
		}
		imageTargetExt = imageTargetExt.toLowerCase();
		if ("".equals(imageTargetExt)
				|| (!"jpg".equals(imageTargetExt)
						&& !"gif".equals(imageTargetExt)
						&& !"png".equals(imageTargetExt) && !"bmp"
						.equals(imageTargetExt))) {// 扩展名不是图片文件
			throw new Exception("imageTargets isn't image! imageTarget="
					+ imageTarget);
		}

		try {
			imageSourceBF = ImageIO.read(imageSourceFile);
		} catch (Exception e) {
			if (imageSourceBF != null) {
				imageSourceBF.flush();
			}
			imageSourceBF = null;
			throw e;
		}
		if (imageSourceBF == null) {
			throw new Exception("imageSource can't be readed! imageSource="
					+ imageSource);
		}

		if (imageSourceBF.getWidth() < 1.0D || imageSourceBF.getHeight() < 1.0D) {
			throw new Exception("imageSource isn't right! imageSource="
					+ imageSource + " width=" + imageSourceBF.getWidth()
					+ " height=" + imageSourceBF.getHeight());
		}
		if (opType == 2
				&& ("gif".equals(imageSourceExt) || "png"
						.equals(imageSourceExt))) {// 直接拷贝
			if (fileUtil.copyFile(imageSourceFile, imageTarget)) {
				return 1;
			}
		}
		// opType优先 1=对宽或高超出预定的进行原图比例等比例的缩放 2=对宽或高超出预定的进行给定比例等比例的缩放
		// 3=对不符合预定比例的进行原图比例缩放 4=对不符合预定比例的进行给定比例缩放
		if ((targetWidth < 1 || targetHeight < 1)
				|| ((zoomType == 1 || zoomType == 2) && (imageSourceBF
						.getWidth() > targetWidth || imageSourceBF.getHeight() > targetHeight))
				|| ((zoomType == 3 || zoomType == 4) && ((imageSourceBF
						.getWidth() / imageSourceBF.getHeight()) != (targetWidth / targetHeight)))) {

			if (targetWidth < 1 || targetHeight < 1) {// 按原来的样子生成图片
				ratio = 1.0d;
			} else {
				ratio_ts_w = ((double) targetWidth) / imageSourceBF.getWidth();
				ratio_ts_h = ((double) targetHeight)
						/ imageSourceBF.getHeight();
				if (ratio_ts_w > ratio_ts_h) {
					ratio = ratio_ts_h;
				} else {
					ratio = ratio_ts_w;
				}
			}
			try {
				fos = new FileOutputStream(imageTarget);
				bos = new BufferedOutputStream(fos);

				if ("gif".equals(imageSourceExt)
						|| "png".equals(imageSourceExt)) {// 处理GIF、png格式的图片
					imageTargetBF = new BufferedImage((int) (imageSourceBF
							.getWidth() * ratio), (int) (imageSourceBF
							.getHeight() * ratio), BufferedImage.TYPE_INT_RGB);
					g = imageTargetBF.getGraphics();
					g.setColor(Color.WHITE);
					g.fillRect(0, 0, (int) (imageSourceBF.getWidth() * ratio),
							(int) (imageSourceBF.getHeight() * ratio));
					g.drawImage(imageSourceBF, 0, 0, (int) (imageSourceBF
							.getWidth() * ratio), (int) (imageSourceBF
							.getHeight() * ratio), null); // 绘制缩小后的图
					g.dispose();
					g = null;
				} else {
					atfop = new AffineTransformOp(AffineTransform
							.getScaleInstance(ratio, ratio), null);
					Itemp = atfop.filter(imageSourceBF, null);
					bos = new BufferedOutputStream(fos);
					imageTargetBF = (BufferedImage) Itemp;
				}

				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(bos);
				encoder.encode(imageTargetBF);
				// 或 都可以 ImageIO.write((BufferedImage) Itemp, "JPEG", fos);
				if (g != null) {
					g.dispose();
				}
				if (Itemp != null) {
					Itemp.flush();
				}
				imageSourceBF.flush();
				imageTargetBF.flush();
				bos.close();
				fos.flush();
				fos.close();

				g = null;
				Itemp = null;
				atfop = null;
				imageSourceBF = null;
				imageTargetBF = null;
				bos = null;
				fos = null;
				encoder = null;
				result = 1;
			} catch (FileNotFoundException fnfe) {
				fnfe.printStackTrace();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				try {
					if (g != null) {
						g.dispose();
						g = null;
					}
					if (Itemp != null) {
						Itemp.flush();
						Itemp = null;
					}
					atfop = null;
					if (imageSourceBF != null) {
						imageSourceBF.flush();
						imageSourceBF = null;
					}
					if (imageTargetBF != null) {
						imageTargetBF.flush();
						imageTargetBF = null;
					}
					if (bos != null) {
						bos.close();
						bos = null;
					}
				} catch (IOException ioexfos) {
					ioexfos.printStackTrace();
				} finally {
					try {
						if (fos != null) {
							fos.close();
							fos = null;
						}
					} catch (IOException ioexfis) {
						ioexfis.printStackTrace();
					}
				}
			}
		} else {// 直接拷贝
			if (fileUtil.copyFile(imageSourceFile, imageTarget)) {
				result = 1;
			} else {
				result = -1;
				throw new Exception("imageSource can't be copied! imageSource="
						+ imageSource + " imageTarget=" + imageTarget);
			}
		}
		return result;
	}

	public static void main(String[] args) {
		ImageZoom imageZoom = new ImageZoom();
		/*
		try {
			imageZoom
					.zoom(
							"D:/java/tomcat5.5/webapps/biosun/product/pic/200701291843430.jpg",
							"D:/b/pic/small200701291843430.jpg", 318, 227, 2, 1);
		} catch (Exception e) {
			e.printStackTrace();
		}
*/
		File filePic = new File("D:/b/product/pic/");
		File fPicList[] = filePic.listFiles();
		int fPicListLength = fPicList != null ? fPicList.length : 0;

		int countExc=0;
		for (int i = 0; i < fPicListLength; i++) {
			try {
				imageZoom.zoom("D:/b/product/pic/"
						+ fPicList[i].getName(), "D:/b/product/small/small"
						+ fPicList[i].getName(), 318, 227, 2, 1);

			} catch (Exception e) {
				countExc++;
				System.out.println("fPicList[i].getName()="
						+ fPicList[i].getName());
				e.printStackTrace();
			}
		}
		System.out.println("countExc="+countExc);
	}
}